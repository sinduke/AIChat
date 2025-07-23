//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by sinduke on 7/23/25.
//

import SwiftUI

struct ChatMessageModel: Identifiable, Codable, Hashable {
    let id: String
    let chatId: String
    let authorId: String?
    let content: String?
    let seenByIds: [String]?
    let dateCreated: Date?
    
    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: String? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }
    
    func hasBeenSeenBy(userId: String) -> Bool {
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }
    
    static var mocks: [Self] {
        [
            Self(
                id: "msg_001",
                chatId: "mock_chat_1",
                authorId: "user_001",
                content: "Hey there! How's it going?",
                seenByIds: ["user_002", "user_003"],
                dateCreated: Date().addingTimeInterval(minutes: -45)
            ),
            Self(
                id: "msg_002",
                chatId: "mock_chat_1",
                authorId: "user_002",
                content: "All good! Working on the new app UI. You?",
                seenByIds: ["user_001"],
                dateCreated: Date().addingTimeInterval(minutes: -30)
            ),
            Self(
                id: "msg_003",
                chatId: "mock_chat_2",
                authorId: "user_003",
                content: "Just had a coffee ☕️ and reading some docs.",
                seenByIds: [],
                dateCreated: Date().addingTimeInterval(minutes: -20)
            ),
            Self(
                id: "msg_004",
                chatId: "mock_chat_2",
                authorId: "user_001",
                content: "Nice! I'm reviewing the API changes.",
                seenByIds: ["user_003"],
                dateCreated: Date().addingTimeInterval(minutes: -5)
            )
        ]
    }
    
    static var mock: Self {
        mocks.first!
    }
    
}
