//
//  FirebaseUserService.swift
//  AIChat
//
//  Created by sinduke on 8/14/25.
//


import FirebaseFirestore
import SwiftfulFirestore

// typealias ListenerRegistration = FirebaseFirestore.ListenerRegistration
struct FirebaseUserService: RemoteUserServiceProtocol {
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
