//
//  LocalUserPersistanceProtocol.swift
//  AIChat
//
//  Created by sinduke on 8/14/25.
//


protocol LocalUserPersistanceProtocol {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
