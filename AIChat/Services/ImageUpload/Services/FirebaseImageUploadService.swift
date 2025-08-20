//
//  FirebaseImageUploadService.swift
//  AIChat
//
//  Created by sinduke on 8/19/25.
//

import SwiftUI
import FirebaseStorage

protocol ImageLoadServiceProtocol {
    func uploadImage(image: UIImage, path: String) async throws -> URL
}

struct FirebaseImageUploadService {
    func uploadImage(image: UIImage, path: String) async throws -> URL {
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.dataNotAllowed)
        }
        // upload Image
        _ = try await saveImage(data: data, path: path)
        // Get downLoad image URL
        return try await imageReference(path: path).downloadURL()
    }
    
    private nonisolated func imageReference(path: String) -> StorageReference {
        let name = "\(path).jpg"
        return Storage.storage().reference(withPath: name)
    }
    
    private func saveImage(data: Data, path: String) async throws -> URL {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let returnMeta = try await imageReference(path: path).putDataAsync(data, metadata: meta)
        
        guard
            let returnPath = returnMeta.path,
            let url = URL(string: returnPath)
        else {
            throw URLError(.badServerResponse)
        }
        
        return url
    }
    
}
