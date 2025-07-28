//
//  TextValidationHelper.swift
//  AIChat
//
//  Created by sinduke on 7/27/25.
//

import SwiftUI

struct TextValidationHelper {
    /**
     \\W*
     匹配非字母数字字符，包括空格、点号、星号等，防止规避检测
     \\b
     单词边界，防止匹配如 class 中的 ass
     */
    private static let profanityPatterns: [String] = [
        "\\bf\\W*u\\W*c\\W*k\\b",
        "\\bs\\W*h\\W*i\\W*t\\b",
        "\\bb\\W*i\\W*t\\W*c\\W*h\\b",
        "\\ba\\W*s\\W*s\\b"
    ]
    
    static func validate(_ text: String, minLength: Int = 4) throws {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 1. 长度验证
        guard trimmedText.count >= minLength else {
            throw TextValidationError.notEnoughCharacters(min: minLength)
        }
        
        // 2. 敏感词验证
        let lowercasedText = trimmedText.lowercased()
        
        for pattern in profanityPatterns where lowercasedText.range(of: pattern, options: .regularExpression) != nil {
            throw TextValidationError.hasBadWords
        }
    }
    
    enum TextValidationError: @preconcurrency LocalizedError {
        case notEnoughCharacters(min: Int)
        case hasBadWords
        
        var errorDescription: String? {
            switch self {
            case .notEnoughCharacters(min: let min):
                "Place add at least \(min) characters."
                
            case .hasBadWords:
                "Bad word detected. Please rephrase your message."
            }
        }
    }

}
