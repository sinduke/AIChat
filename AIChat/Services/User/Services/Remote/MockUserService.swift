//
//  MockUserService.swift
//  AIChat
//
//  Created by sinduke on 8/14/25.
//


struct MockUserService: RemoteUserServiceProtocol {
    
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
