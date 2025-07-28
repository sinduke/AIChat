//
//  AvatarAttributes.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

enum CharacterOption: String, Codable, Hashable, CaseIterable, Identifiable {
    case man, woman, dog, cat, alien

    var id: Self { self }

    static var `default`: Self {
        .cat
    }

    var startsWithVowel: Bool {
        [.alien].contains(self)
    }
    /**
     极其特殊的用法
     Text("^[\(count) Person](inflect: true)")
     */
    var plural: String {
        switch self {
        case .man:
            "men"
            
        case .woman:
            "women"
            
        case .dog:
            "dogs"
            
        case .cat:
            "cats"
            
        case .alien:
            "aliens"
        }
    }
}

enum CharacterAction: String, Codable, Hashable, CaseIterable, Identifiable {
    case eating, drinking, sleeping, reading, typing, thinking, smiling, laughing, crying, blushing, fighting, studying
    static var `default`: Self {
        .eating
    }
    var id: Self { self }
}

enum CharacterLocation: String, Codable, Hashable, CaseIterable, Identifiable {
    case home, office, school, park, cafe, library, gym, beach, mountain, city, countryside
    static var `default`: Self {
        .home
    }
    var id: Self { self }
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
        let prefix = characterOption == .alien ? "An" : "A"
        return "\(prefix) \(characterOption.rawValue) that is \(characterAction) in the \(characterLocation)!"
    }
}
