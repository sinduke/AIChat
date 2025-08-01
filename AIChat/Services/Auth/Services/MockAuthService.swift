//
//  MockAuthService.swift
//  AIChat
//
//  Created by sinduke on 8/1/25.
//


struct MockAuthService: AuthServiceProtocol {
    
    let currentUser: UserAuthInfo?
    
    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let isAnonymous = true
        let user = UserAuthInfo.mock(isAnonymous: isAnonymous)
        return (user, isAnonymous)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let isAnonymous = false
        let user = UserAuthInfo.mock(isAnonymous: isAnonymous)
        return (user, isAnonymous)
    }
    
    func signOut() throws {
        
    }
    
    func deleteAccount() async throws {
        
    }
}
