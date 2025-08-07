//
//  UserManager.swift
//  AIChat
//
//  Created by sinduke on 8/1/25.
//

import SwiftUI

protocol UserServiceProtocol {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}

struct MockUserService: UserServiceProtocol {
    
    let user: UserModel?
    
    init(user: UserModel? = nil) {
        self.user = user
    }
    
    func saveUser(user: UserModel) async throws {
        
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let user {
                continuation.yield(user)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {
        
    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        
    }
}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: UserServiceProtocol {
    var collection: CollectionReference {
        Firestore.firestore().collection("user")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}

@Observable
class UserManager {
    private let service: UserServiceProtocol
    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?
    
    init(service: UserServiceProtocol) {
        self.service = service
        self.currentUser = nil
    }
    
    func login(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let createVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, createVersion: createVersion)
        
        try await service.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        
        Task {
            do {
                for try await value in service.streamUser(userId: userId) {
                    self.currentUser = value
                    print("Success listener to user: \(userId)")
                }
            } catch {
                print("Error attaching user listener \(error)")
            }
        }
        
    }
    
    func markOnboardingCompleted(profileColorHex: String) async throws {
        let uid = try currentUserId()
        print(uid)
        try await service.markOnboardingCompleted(userId: uid, profileColorHex: profileColorHex)
    }
    
    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await service.deleteUser(userId: uid)
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
