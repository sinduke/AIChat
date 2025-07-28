//
//  ChatRowCellViewBuilder.swift
//  AIChat
//
//  Created by sinduke on 7/23/25.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {
    
    var currentUserId: String? = ""
    var chat: ChatModel = ChatModel.mock
    
    var getAvatar: () async -> AvatarModel?
    var getLastChatMessage: () async -> ChatMessageModel?
    
    @State private var avatar: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?
    
    @State private var didLoadAvatar: Bool = false
    @State private var didLoadMessage: Bool = false
    
    private var subheadline: String? {
        if isLoading {
            return "xxx xxx xxx xxx"
        }
        if avatar == nil && lastChatMessage == nil {
            return "Error load, please retry"
        } else if lastChatMessage == nil {
            return "No message here"
        }
        return lastChatMessage?.content
    }
    
    private var isLoading: Bool {
        !(didLoadAvatar && didLoadMessage)
    }
    
    private var hasNewMessage: Bool {
        guard let lastChatMessage, let currentUserId else { return false }
        return lastChatMessage.hasBeenSeenBy(userId: currentUserId)
    }
    
    var body: some View {
        ChatRowCellView(
            imageName: avatar?.profileImageName,
            title: isLoading ? "xxx xxx" : avatar?.name,
            subTitle: subheadline,
            hasNewMessage: isLoading ? false : hasNewMessage
        )
        .if(isLoading) { $0.redacted(reason: .placeholder) }
        .task {
            avatar = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastChatMessage = await getLastChatMessage()
            didLoadMessage = true
        }
    }
}

#Preview {
    ZStack {
        Color.indigo.opacity(0.22).ignoresSafeArea()
        VStack {
            ChatRowCellViewBuilder(chat: .mock, getAvatar: {
//                try? await Task.sleep(for: 3)
                return .mock
            }, getLastChatMessage: {
//                try? await Task.sleep(for: .seconds(5))
                return .mock
            })
            
            ChatRowCellViewBuilder(chat: .mock, getAvatar: {
                .mock
            }, getLastChatMessage: {
                .mock
            })
            
            ChatRowCellViewBuilder(chat: .mock, getAvatar: {
                nil
            }, getLastChatMessage: {
                nil
            })
            
            ChatRowCellViewBuilder(chat: .mock, getAvatar: {
                .mock
            }, getLastChatMessage: {
                nil
            })
            
            ChatRowCellViewBuilder(chat: .mock, getAvatar: {
                nil
            }, getLastChatMessage: {
                .mock
            })
        }
    }
}
