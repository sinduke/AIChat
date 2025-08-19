//
//  OpenAIService.swift
//  AIChat
//
//  Created by sinduke on 8/19/25.
//

import SwiftUI
import OpenAI

struct OpenAIService: AIServiceProtocol {
    
    let config = OpenAI.Configuration(
        token: Keys.openAIKey,
        organizationIdentifier: nil,
        host: "api.gptsapi.net",
        port: 443,
        scheme: "https",
        basePath: "/v1"
    )
    
    var openAI: OpenAI {
        OpenAI(configuration: config)
    }
    
    func generateImage(input: String) async throws -> UIImage {
        
        let query = ImagesQuery(
            prompt: input,
            model: .dall_e_3,
            n: 1,
            quality: .hd,
            responseFormat: .b64_json,
            size: ._1024,
            style: .natural,
            user: nil
        )
        
        let result = try await openAI.images(query: query)
        
        guard
            let b64Json = result.data.first?.b64Json,
            let data = Data(base64Encoded: b64Json),
            let image = UIImage(data: data) else {
            throw OpenAIError.invalidResponse
        }
        
        return image
    }
    
    enum OpenAIError: LocalizedError {
        case invalidResponse
    }
}
