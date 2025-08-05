//
//  UserManager.swift
//  AIChat
//
//  Created by sinduke on 8/1/25.
//

import SwiftUI

protocol UserServiceProtocol {
    func saveUser(user: UserModel) throws
}

import FirebaseFirestore

struct FirebaseUserService: UserServiceProtocol {
    var collection: CollectionReference {
        Firestore.firestore().collection("user")
    }
    
    func saveUser(user: UserModel) throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
}

@Observable
class UserManager {
    private let service: UserServiceProtocol
    private(set) var currentUser: UserModel?
    
    init(service: UserServiceProtocol) {
        self.service = service
        self.currentUser = nil
    }
    
    func login(user: UserAuthInfo, isNewUser: Bool) throws {
        let createVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: user, createVersion: createVersion)
        
        try service.saveUser(user: user)
    }
    
}
