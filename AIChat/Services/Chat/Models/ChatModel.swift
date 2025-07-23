//
//  ChatModel.swift
//  AIChat
//
//  Created by sinduke on 7/22/25.
//

import SwiftUI

struct ChatModel: Identifiable, Hashable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date

    static let mocks: [Self] = [
        Self(
            id: "mock_chat_1",
            userId: "user_001",
            avatarId: "avatar_001",
            dateCreated: Date().addingTimeInterval(hours: -1),      // 1 小时前
            dateModified: Date().addingTimeInterval(minutes: -30)   // 30 分钟前
        ),
        Self(
            id: "mock_chat_2",
            userId: "user_002",
            avatarId: "avatar_002",
            dateCreated: Date().addingTimeInterval(hours: -3),      // 3 小时前
            dateModified: Date().addingTimeInterval(hours: -2)      // 2 小时前
        ),
        Self(
            id: "mock_chat_3",
            userId: "user_003",
            avatarId: "avatar_003",
            dateCreated: Date().addingTimeInterval(days: -1),       // 昨天创建
            dateModified: Date().addingTimeInterval(hours: -20)     // 今天凌晨修改
        ),
        Self(
            id: "mock_chat_4",
            userId: "user_004",
            avatarId: "avatar_004",
            dateCreated: Date().addingTimeInterval(days: -2, hours: -2),  // 前天晚上
            dateModified: Date().addingTimeInterval(days: -1, hours: -4)  // 昨天下午
        )
    ]

    static let mock: Self = mocks.first!

}
