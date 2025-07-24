//
//  UserModel.swift
//  AIChat
//
//  Created by sinduke on 7/23/25.
//

import SwiftUI

struct UserModel: Codable, Identifiable, Hashable {
    var id: String {
        userId
    }
    let userId: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        dateCreated: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    var profileColorCalculated: Color {
        guard let hex = profileColorHex, hex.hasPrefix("#") || hex.count == 6 else {
            return .accent
        }
        return Color(hex: hex)
    }
    
    static let mock: Self = mocks.first!
    
    static let mocks: [Self] = {
        let now = Date()
        return [
            Self(
                userId: "user_001",
                dateCreated: now,
                didCompleteOnboarding: true,
                profileColorHex: "#FF5733" // 红橙
            ),
            Self(
                userId: "user_002",
                dateCreated: now.addingTimeInterval(days: -1),
                didCompleteOnboarding: false,
                profileColorHex: "#33C1FF" // 蓝
            ),
            Self(
                userId: "user_003",
                dateCreated: now.addingTimeInterval(days: -3, hours: -5),
                didCompleteOnboarding: nil,
                profileColorHex: "#85FF33" // 绿
            ),
            Self(
                userId: "user_004",
                dateCreated: nil,
                didCompleteOnboarding: true,
                profileColorHex: nil
            ),
            Self(
                userId: "user_005",
                dateCreated: now.addingTimeInterval(hours: -2, minutes: -30),
                didCompleteOnboarding: false,
                profileColorHex: "#F1C40F" // 金黄
            )
        ]
    }()
}
