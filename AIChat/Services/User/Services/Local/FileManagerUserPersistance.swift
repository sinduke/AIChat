//
//  FileManagerUserPersistance.swift
//  AIChat
//
//  Created by sinduke on 8/14/25.
//

import SwiftUI

struct FileManagerUserPersistance: LocalUserPersistanceProtocol {
    
    private let userKey = "current_user"
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userKey)
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument(key: userKey, value: user)
    }
    
}
