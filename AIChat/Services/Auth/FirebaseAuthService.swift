//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by sinduke on 7/29/25.
//

import FirebaseAuth
import SwiftUI

extension EnvironmentValues {
    @Entry var authService: FirebaseAuthService = FirebaseAuthService()
}

struct UserAuthInfo {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let creationDate: Date?
    let lastSignInDate: Date?
    
    init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool = false,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
    
}

struct FirebaseAuthService {
    
    // 查询是否已经登录 User是Firebase中的定义 需要解耦
    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser {
            return UserAuthInfo(user: user)
        }
        return nil
    }
    
    // 匿名登录 signInAnonymously的返回值是AuthDataResult 来自Firebase 需要解耦
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        let user = UserAuthInfo(user: result.user)
        
        let isNewUser = result.additionalUserInfo?.isNewUser ?? true
        
        return (user, isNewUser)
    }
    
}
