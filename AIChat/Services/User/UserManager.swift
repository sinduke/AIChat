//
//  UserManager.swift
//  AIChat
//
//  Created by sinduke on 8/1/25.
//

import SwiftUI
internal import FirebaseFirestoreInternal

@MainActor
@Observable
class UserManager {
    private let remote: RemoteUserServiceProtocol
    private let local: LocalUserPersistanceProtocol
    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?
    
    // 尽量避免在@Observable的init中做复杂的事情。因为暂时多次初始化无法避免 其核心问题是Observable和@State组合之后的结果
    init(service: UserServicesProtocol) {
        self.remote = service.remote
        self.local = service.local
        self.currentUser = local.getCurrentUser()
    }
    
    func login(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let createVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, createVersion: createVersion)
        
        try await remote.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        
        Task {
            do {
                for try await value in remote.streamUser(userId: userId) {
                    self.currentUser = value
                    self.saveCurrentUserLocally()
                    print("Success listener to user: \(userId)")
                }
            } catch {
                print("Error attaching user listener \(error)")
            }
        }
        
    }
    
    private func saveCurrentUserLocally() {
        Task {
            do {
                try local.saveCurrentUser(user: currentUser)
                print("Successfully saved current user: \(String(describing: currentUser?.userId))")
            } catch {
                print("Error saving current user locally: \(error)")
            }
        }
    }
    
    func markOnboardingCompleted(profileColorHex: String) async throws {
        let uid = try currentUserId()
        print(uid)
        try await remote.markOnboardingCompleted(userId: uid, profileColorHex: profileColorHex)
    }
    
    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await remote.deleteUser(userId: uid)
    }
    
    private func currentUserId() throws -> String {
        print("准备获取用户的UID")
        guard let uid = currentUser?.userId else {
            print("获取用户的UID失败")
            throw UserManagerError.noUserId
        }
        print("获取用户的UID成功")
        return uid
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
