//
//  AvatarModel.swift
//  AIChat
//
//  Created by sinduke on 7/19/25.
//

import SwiftUI

struct AvatarModel: Codable, Hashable, Identifiable {
    var id: String { avatarId }
    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    private(set) var profileImageName: String?
    let autherId: String?
    let dateCrerated: Date?

    init(
        avatarId: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageName: String? = nil,
        autherId: String? = nil,
        dateCrerated: Date? = nil
    ) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageName = profileImageName
        self.autherId = autherId
        self.dateCrerated = dateCrerated
    }

    var characterDescription: String {
        AvatarDescriptionBuilder(avatar: self).avatarDiscription
    }
    
    mutating func updateProfileImage(imageName: String) {
        profileImageName = imageName
    }
    
    enum CodingKeys: String, @preconcurrency CodingKey {
        case avatarId = "avatar_id"
        case name
        case characterOption = "character_option"
        case characterAction = "character_action"
        case characterLocation = "character_location"
        case profileImageName = "profile_image_name"
        case autherId = "auther_id"
        case dateCrerated = "date_crerated"
    }

    static var mocks: [Self] {
        [
            Self(
                avatarId: UUID().uuidString,
                name: "Alpha",
                characterOption: .alien,
                characterAction: .smiling,
                characterLocation: .school,
                profileImageName: Constants.randomImages,
                autherId: UUID().uuidString,
                dateCrerated: .now
            ),
            Self(
                avatarId: UUID().uuidString,
                name: "Bella",
                characterOption: .woman,
                characterAction: .reading,
                characterLocation: .library,
                profileImageName: Constants.randomImages,
                autherId: UUID().uuidString,
                dateCrerated: .now
            ),
            Self(
                avatarId: UUID().uuidString,
                name: "Charlie",
                characterOption: .dog,
                characterAction: .sleeping,
                characterLocation: .home,
                profileImageName: Constants.randomImages,
                autherId: UUID().uuidString,
                dateCrerated: .now
            ),
            Self(
                avatarId: UUID().uuidString,
                name: "Daisy",
                characterOption: .cat,
                characterAction: .typing,
                characterLocation: .cafe,
                profileImageName: Constants.randomImages,
                autherId: UUID().uuidString,
                dateCrerated: .now
            )
        ]
    }

    static var mock: Self {
        mocks.first!
    }
}
