//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by sinduke on 7/29/25.
//

@preconcurrency import FirebaseAuth
import SwiftUI
import SignInAppleAsync

struct FirebaseAuthService: AuthServiceProtocol {
    
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
        return result.asUserInfo
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = SignInWithAppleHelper()
        let response  = try await helper.signIn()
        
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce
        )
        
        // 匿名账号则进行绑定
        if let user = Auth.auth().currentUser, user.isAnonymous {
            do {
                return try await Task.detached(priority: nil) {
                    let result = try await user.link(with: credential)
                    return await result.asUserInfo
                }.value
            } catch let error as NSError {
                let authError = AuthErrorCode(rawValue: error.code)
                
                switch authError {
                case .credentialAlreadyInUse, .providerAlreadyLinked:
                    // ✅ Firebase 12.0.0 会通过 userInfo 提供推荐登录的 credential
                    if let updatedCredential = error.userInfo[AuthErrorUserInfoUpdatedCredentialKey] as? AuthCredential {
                        let result = try await Auth.auth().signIn(with: updatedCredential)
                        return result.asUserInfo
                    } else {
                        throw AuthError.linkFailed(error)
                    }

                default:
                    throw AuthError.linkFailed(error)
                }
            }
        }
        
        // 否则直接创建新的第三方账户
        let result = try await Auth.auth().signIn(with: credential)
        return result.asUserInfo
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.delete()
    }
    
    enum AuthError: LocalizedError {
        case userNotFound
        case linkFailed(Error)
        
        nonisolated var errorDescription: String? {
            switch self {
            case .userNotFound:
                "Current user Not Found!"
                
            case .linkFailed(let error):
                "Anonymously bingding failed \(error.localizedDescription)"
            }
        }
    }
}

extension AuthDataResult {
    var asUserInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        
        return (user, isNewUser)
    }
}
