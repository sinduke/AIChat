//
//  MockProvider.swift
//  AIChat
//
//  Created by sinduke on 7/23/25.
//

import SwiftUI

/**

 ✅ 基础方法调用示例

 1. callAsFunction()

 常用：

 let mock = MockProvider(value: { "Hello" })
 let result = try await mock()
 print(result) // 输出 "Hello"

 极限：

 let throwingMock = MockProvider<String>(throws: URLError(.notConnectedToInternet), value: { fatalError("Should not reach here") })
 do {
     _ = try await throwingMock()
 } catch {
     print("Expected error: \(error)")
 }


 ⸻

 2. async() → 返回一个可复用的 async/throws 函数

 常用：

 let mock = MockProvider(value: { 42 })
 let closure = mock.async()
 let result = try await closure()
 print(result) // 42

 极限：

 func testRepeated(_ closure: @escaping () async throws -> Int) async {
     for _ in 0..<5 {
         print(try await closure())
     }
 }
 let mock = MockProvider(value: { Int.random(in: 0...100) })
 await testRepeated(mock.async())


 ⸻

 3. asyncOptional() → 返回 Optional 值（错误不抛出）

 常用：

 let mock = MockProvider(value: { "Hello Optional" })
 let optional = await mock.asyncOptional()()
 print(optional ?? "nil")

 极限：

 let mock = MockProvider<String>(throws: NSError(domain: "Fail", code: 1), value: { "Should not appear" })
 let result = await mock.asyncOptional()()
 print(result == nil ? "Error was silenced correctly" : "Unexpected success")


 ⸻

 4. asyncResult() → 返回 Result<T, Error>

 常用：

 let mock = MockProvider(value: { 100 })
 let result = await mock.asyncResult()()
 switch result {
 case .success(let value): print("Got: \(value)")
 case .failure(let error): print("Failed: \(error)")
 }

 极限：

 let mock = MockProvider<Int>(throws: URLError(.timedOut), value: { -1 })
 let result = await mock.asyncResult()()
 assert(result.isFailure)


 ⸻

 🧪 工厂方法（模拟器）

 ⸻

 5. .random(success:or:)

 常用：

 let mock = MockProvider.random(success: "Yay", or: NSError(domain: "Mock", code: 0))
 do {
     print(try await mock())
 } catch {
     print("Randomly failed")
 }

 极限：

 let stats = try await (0..<1000).asyncCompactMap { _ in
     try? await MockProvider.random(success: 1, or: URLError(.badURL))()
 }
 print("Success ratio: \(Double(stats.count) / 1000)")


 ⸻

 6. .withProbability(success:failure:ratio:)

 常用：

 let mock = MockProvider.withProbability(success: "OK", failure: URLError(.notConnectedToInternet), ratio: 0.75)
 print(try? await mock())

 极限（统计概率）：

 var successCount = 0
 for _ in 0..<1000 {
     let result = try? await MockProvider.withProbability(success: true, failure: NSError(), ratio: 0.1)()
     if result == true { successCount += 1 }
 }
 print("Observed success rate: \(Double(successCount) / 1000)")


 ⸻

 7. .sequence(_:)

 常用：

 let mock = MockProvider.sequence(["A", "B", "C"])
 print(try await mock()) // A
 print(try await mock()) // B
 print(try await mock()) // C
 print(try await mock()) // C（停在最后一个）

 极限：

 let mock = MockProvider.sequence(["1", "2", "3"])
 for _ in 0..<10 {
     print(try await mock()) // 最后将一直输出 "3"
 }


 ⸻

 8. .looping(_:)

 常用：

 let mock = MockProvider.looping(["A", "B", "C"])
 print(try await mock()) // A
 print(try await mock()) // B
 print(try await mock()) // C
 print(try await mock()) // A（循环回来了）

 极限（应用在 UI 循环页索引模拟）：

 let indexMock = MockProvider.looping([0, 1, 2, 3, 4])
 for _ in 0..<20 {
     print(try await indexMock())
 }


 ⸻

 ✅ 总结（按场景分类）

 功能    场景    示例
 callAsFunction()    基本获取数据    try await mock()
 async()    注入 callback 或定时器中    Task { try await closure() }
 asyncOptional()    UI 流中无需处理错误    let result = await mock.asyncOptional()()
 asyncResult()    结构化错误显示或 log    await mock.asyncResult()()
 random()    A/B、灰度、波动测试    随机失败 UI 测试
 withProbability()    某些情况高失败率    统计重试行为
 sequence()    模拟步骤、对话、流程    一步步执行
 looping()    模拟轮播、队列调度    无限循环

 */

struct MockProvider<T: Sendable>: Sendable {
    
    private let provider: @Sendable () async throws -> T
    
    init(
        delay: TimeInterval = 0,
        throws error: Error? = nil,
        value: @escaping @Sendable () async throws -> T
    ) {
        self.provider = {
            if delay > 0 {
                try await Task.sleep(for: .seconds(delay))
            }
            if let error {
                throw error
            }
            return try await value()
        }
    }
    
    // MARK: -- 基础能力 --
    func callAsFunction() async throws -> T {
        try await provider()
    }
    
    func async() -> @Sendable () async throws -> T {
        provider
    }
    
    func asyncOptional() -> @Sendable () async -> T? {
        { try? await provider() }
    }
    
    func asyncResult() -> @Sendable () async -> Result<T, Error> {
        {
            do {
                let result = try await provider()
                return .success(result)
            } catch {
                return .failure(error)
            }
        }
    }
    
    var function: () async -> T? {
        asyncOptional()
    }
}

extension MockProvider {
    actor IndexTracker {
        private var index = 0
        let looping: Bool

        init(looping: Bool = false) {
            self.looping = looping
        }

        func nextIndex(count: Int) -> Int {
            let current = index
            if looping {
                index = (index + 1) % count
            } else {
                index = min(index + 1, count - 1)
            }
            return current
        }
    }
    
    // MARK: - 随机成功或失败
    static func random(success: T, or error: Error) -> Self {
        .init {
            if Bool.random() {
                return success
            } else {
                throw error
            }
        }
    }
    
    // MARK: - 概率控制成功或失败
    static func withProbability(success: T, failure: Error, ratio: Double) -> Self {
        .init {
            if Double.random(in: 0...1) < ratio {
                return success
            } else {
                throw failure
            }
        }
    }
    
    // MARK: - 序列模拟：依次返回数组中的值
    static func sequence(_ values: [T], delay: TimeInterval = 0) -> Self {
        let tracker = IndexTracker()

        return .init(delay: delay) {
            guard !values.isEmpty else {
                fatalError("Empty sequence passed to MockProvider.sequence")
            }

            let index = await tracker.nextIndex(count: values.count)
            return values[index]
        }
    }
    
    // MARK: - 循环模拟：无限循环返回数组中的值
    static func looping(_ values: [T], delay: TimeInterval = 0) -> Self {
        let tracker = IndexTracker(looping: true)

        return .init(delay: delay) {
            guard !values.isEmpty else {
                fatalError("Empty array passed to MockProvider.looping")
            }

            let index = await tracker.nextIndex(count: values.count)
            return values[index]
        }
    }
}
