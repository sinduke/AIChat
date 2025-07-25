//
//  ChatBubbleViewBuilder.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
    
    var message: ChatMessageModel = .mock
    var isCurrentUser: Bool = false
    var imageName: String?
    
    var body: some View {
        ChatBubbleView(
            text: message.content ?? "",
            textColor: isCurrentUser ? .white : .primary,
            backgroundColor: isCurrentUser ? .accent : Color(.systemGray6),
            showImage: !isCurrentUser,
            imageName: imageName
        )
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
        .padding(.leading, isCurrentUser ? 50 : 0)
        .padding(.trailing, isCurrentUser ? 0 : 20)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ChatBubbleViewBuilder(isCurrentUser: true)
            ChatBubbleViewBuilder()
            ChatBubbleViewBuilder(isCurrentUser: true)
            ChatBubbleViewBuilder()
            ChatBubbleViewBuilder(
                message: ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    authorId: UUID().uuidString,
                    // swiftlint:disable:next line_length
                    content: "This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content.",
                    seenByIds: nil,
                    dateCreated: .now
                ),
                isCurrentUser: true,
                imageName: nil
            )
            ChatBubbleViewBuilder(
                message: ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    authorId: UUID().uuidString,
                    // swiftlint:disable:next line_length
                    content: "This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content. This is long content.",
                    seenByIds: nil,
                    dateCreated: .now
                ),
                isCurrentUser: false,
                imageName: Constants.randomImages
            )
        }
        .padding()
    }
}
