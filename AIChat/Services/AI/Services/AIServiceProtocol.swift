//
//  AIServiceProtocol.swift
//  AIChat
//
//  Created by sinduke on 8/19/25.
//

import SwiftUI

protocol AIServiceProtocol {
    func generateImage(input: String) async throws -> UIImage
}
