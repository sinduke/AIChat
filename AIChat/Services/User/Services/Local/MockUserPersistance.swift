//
//  MockUserPersistance.swift
//  AIChat
//
//  Created by sinduke on 8/14/25.
//


struct MockUserPersistance: LocalUserPersistanceProtocol {
    let user: UserModel?
    
    init(user: UserModel? = nil) {
        self.user = user
    }
    
    func getCurrentUser() -> UserModel? {
        user
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        
    }
}
