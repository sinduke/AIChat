//
//  AIManager.swift
//  AIChat
//
//  Created by sinduke on 8/18/25.
//

import SwiftUI

@MainActor
@Observable
class AIManager {
    private let service: AIServiceProtocol
    
    init(service: AIServiceProtocol) {
        self.service = service
    }
    
    func generateImage(input: String) async throws -> UIImage {
        try await service.generateImage(input: input)
    }
    
}
