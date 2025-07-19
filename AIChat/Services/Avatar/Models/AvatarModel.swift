//
//  AvatarModel.swift
//  AIChat
//
//  Created by sinduke on 7/19/25.
//

import SwiftUI

struct AvatarModel: Codable {
    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
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

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation

    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }

    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }

    var avatarDiscription: String {
        "A \(characterOption.rawValue) that is \(characterAction) in the \(characterLocation)!"
    }
}

enum CharacterOption: String, Codable {
    case man, woman, dog, cat, alien
    static var `default`: Self {
        .cat
    }
}

enum CharacterAction: String, Codable {
    case eating, drinking, sleeping, reading, typing, thinking, smiling, laughing, crying, blushing, fighting, studying
    static var `default`: Self {
        .eating
    }
}

enum CharacterLocation: String, Codable {
    case home, office, school, park, cafe, library, gym, beach, mountain, city, countryside, other
    static var `default`: Self {
        .home
    }
}
