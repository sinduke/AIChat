//
//  RetryHelper.swift
//  AIChat
//
//  Created by sinduke on 8/5/25.
//

import SwiftUI

struct RetryHelper {
    enum RetryError: Error {
        case invalidRetryCount
        case taskCancelled
    }

    /// 执行带重试机制的异步任务
    /// - Parameters:
    ///   - maxRetries: 最大重试次数（包括初始执行）
    ///   - backoff: 每次失败后的延迟策略（单位：秒，默认指数退避）
    ///   - maxDelay: 最大允许延迟（秒），用于限制 backoff（默认不限制）
    ///   - onRetry: 每次失败重试时触发的回调（包含 attempt、error）
    ///   - task: 要执行的异步任务
    /// - Returns: 成功的结果
    /// - Throws: 达到最大重试仍失败时抛出最后一个错误
    @discardableResult
    public static func retry<T>(
        maxRetries: Int,
        backoff: (Int) -> UInt64 = { attempt in UInt64(pow(2.0, Double(attempt))) },
        maxDelay: UInt64? = nil,
        onRetry: ((Int, Error) -> Void)? = nil,
        task: @escaping () async throws -> T
    ) async throws -> T {
        guard maxRetries > 0 else {
            throw RetryError.invalidRetryCount
        }

        for attempt in 1...maxRetries {
            if Task.isCancelled {
                throw RetryError.taskCancelled
            }

            do {
                return try await task()
            } catch {
                if attempt < maxRetries {
                    let rawDelay = backoff(attempt)
                    let delay = maxDelay.map { min($0, rawDelay) } ?? rawDelay

                    onRetry?(attempt, error)
                    print("[Retry] 第 \(attempt) 次失败，\(delay) 秒后重试: \(error)")

                    try? await Task.sleep(nanoseconds: delay * 1_000_000_000)
                } else {
                    print("[Retry] 已达到最大重试次数 (\(maxRetries))，任务失败: \(error)")
                    throw error
                }
            }
        }

        fatalError("[RetryHelper] 理论上永远不应该执行到这里")
    }

    // 示例用法（在其他模块中）
    /*
    try await RetryHelper.retry(maxRetries: 3) {
        try someService.fetchData()
    }

    try await RetryHelper.retry(
        maxRetries: 5,
        backoff: { attempt in UInt64(pow(2.0, Double(attempt))) },
        maxDelay: 10,
        onRetry: { attempt, error in
            Analytics.logRetryEvent(attempt: attempt, error: error)
        }
    ) {
        try userManager.login(user: user, isNewUser: true)
    }
    */
}
