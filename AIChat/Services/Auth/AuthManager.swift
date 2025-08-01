//
//  AuthManager.swift
//  AIChat
//
//  Created by sinduke on 8/1/25.
//

import SwiftUI

/**
 @Environment(\.abc) private var authService abc是Struct/Protocol等 需要有extension EnvironmentValues 支撑使用@Entry注入
 @Environment(bcd())bcd是Class
 */

@Observable
class AuthManager {
    private let service: AuthServiceProtocol
    private(set) var auth: UserAuthInfo?
    private var listener: (any NSObjectProtocol)?
    
    init(service: AuthServiceProtocol) {
        self.service = service
        self.auth = service.getAuthenticatedUser()
        self.addAuthListener()
    }
    
    private func addAuthListener() {
        Task {
            for await auth in service.addAuthenticatedUserListener(onListenerAttached: { listener in
                self.listener = listener
            }) {
                self.auth = auth
                print("Auth listener is Starting. UID: \(auth?.uid ?? "no uid")")
            }
        }
    }
    
    // 不实现getAuthenticatedUser这个方法 在初始化的时候直接通过service获取 UserAuthInfo
    
    func getAuthId() throws -> String {
        guard let uid = auth?.uid else {
            throw AuthError.notSignedIn
        }
        return uid
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await service.signInAnonymously()
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await service.signInApple()
    }
    
    func signOut() throws {
        try service.signOut()
        auth = nil
    }
    
    func deleteAccount() async throws {
        try await service.deleteAccount()
        auth = nil
    }
    
    enum AuthError: LocalizedError {
        case notSignedIn
    }
}
