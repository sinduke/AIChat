//
//  UserModel.swift
//  AIChat
//
//  Created by sinduke on 7/23/25.
//

import SwiftUI
import IdentifiableByString

actor UserModelStorage {
    private var user: UserModel?
    
    func set(_ newUser: UserModel) {
        self.user = newUser
    }
    
    func get() -> UserModel? {
        return user
    }
}

struct UserModel: Codable {
    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let createdDate: Date?
    let createdVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        createdDate: Date? = nil,
        createdVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.createdDate = createdDate
        self.lastSignInDate = lastSignInDate
        self.createdVersion = createdVersion
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    init(auth: UserAuthInfo, createVersion: String?) {
        self.init(
            userId: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            createdDate: auth.creationDate,
            createdVersion: createVersion,
            lastSignInDate: auth.lastSignInDate
        )
    }
    
    static let mock: Self = mocks.first!
    
    static let mocks: [Self] = {
        let now = Date()
        return [
            Self(
                userId: "user_001",
                didCompleteOnboarding: true,
                profileColorHex: "#FF5733" // 红橙
            ),
            Self(
                userId: "user_002",
                didCompleteOnboarding: false,
                profileColorHex: "#33C1FF" // 蓝
            ),
            Self(
                userId: "user_003",
                didCompleteOnboarding: nil,
                profileColorHex: "#85FF33" // 绿
            ),
            Self(
                userId: "user_004",
                didCompleteOnboarding: true,
                profileColorHex: nil
            ),
            Self(
                userId: "user_005",
                didCompleteOnboarding: false,
                profileColorHex: "#F1C40F" // 金黄
            )
        ]
    }()
}

extension UserModel {
    
    enum CodingKeys: String, @preconcurrency CodingKey {
        case userId = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case createdDate = "created_date"
        case lastSignInDate = "last_sign_in_date"
        case createdVersion = "created_version"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
    }
    
    @MainActor
    var profileColorCalculated: Color {
        guard let hex = profileColorHex, hex.hasPrefix("#") || hex.count == 6 else {
            return .accent
        }
        return Color(hex: hex)
    }
}
