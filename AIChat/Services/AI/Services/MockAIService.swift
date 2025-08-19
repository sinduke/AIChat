//
//  MockAIService.swift
//  AIChat
//
//  Created by sinduke on 8/19/25.
//

import SwiftUI

struct MockAIService: AIServiceProtocol {
    func generateImage(input: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(2))
        return UIImage(systemName: "star.fill")!
    }
}
