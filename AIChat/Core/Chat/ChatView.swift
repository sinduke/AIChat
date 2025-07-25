//
//  ChatView.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

struct ChatView: View {
    
    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel?
    @State private var currentUser: UserModel = .mock
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(chatMessages) { message in
                        let isCurrentUser = message.authorId == currentUser.userId
                        ChatBubbleViewBuilder(
                            message: message,
                            isCurrentUser: isCurrentUser,
                            imageName: isCurrentUser ? nil : avatar?.profileImageName
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            Rectangle()
                .frame(height: 50)
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
