//
//  AvatarManager.swift
//  AIChat
//
//  Created by sinduke on 8/19/25.
//

import SwiftUI

// Xcode26 之前似乎这里需要标记Sendable Sending self.service risks causing data races
protocol AvatarServiceProtocol {
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws
}

struct MockAvatarService: AvatarServiceProtocol {
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        
    }
}

import FirebaseFirestore

struct FirebaseAvatarService: AvatarServiceProtocol {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("avatars")
    }
    
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        // upload image
        let path = "avatars/\(avatar.avatarId)"
        let url = try await FirebaseImageUploadService().uploadImage(image: image, path: path)
        // update avatar profileImage
        var avatar = avatar
        avatar.updateProfileImage(imageName: url.absoluteString)
        // upload avatar
        try collection.document(avatar.avatarId).setData(from: avatar, merge: true)
    }
}

@MainActor
@Observable
class AvatarManager {
    private let service: AvatarServiceProtocol
    
    init(service: AvatarServiceProtocol) {
        self.service = service
    }
    
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        try await service.createAvatar(avatar: avatar, image: image)
    }
}
