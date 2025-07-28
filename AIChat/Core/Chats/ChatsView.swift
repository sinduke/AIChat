//
//  ChatsView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var recentAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !recentAvatars.isEmpty {
                    recentsSection
                }
                chatsSection
            }
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    // MARK: -- View --
    private var recentsSection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(recentAvatars) { avatar in
                        if let imageName = avatar.profileImageName {
                            VStack {
                                ImageLoaderView(urlString: imageName)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(.circle)
                                Text(avatar.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .anyButton(.plain) {
                                onAvatarPressed(avatar: avatar)
                            }
                        }
                    }
                }
                .padding(.top, 12)
            }
            .frame(height: 120)
            .scrollIndicators(.hidden)
        } header: {
            Text("recents".uppercased())
        }
        .removeListRowFormatting()
    }
    
    private var chatsSection: some View {
        Section {
            if chats.isEmpty {
                Text("Your chats will appear here!")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .removeListRowFormatting()
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(40)
            } else {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: nil,
                        chat: chat,
                        getAvatar: {
                            try? await Task.sleep(for: .seconds(1))
                            return AvatarModel.mocks.randomElement()!
                        },
                        getLastChatMessage: {
                            try? await Task.sleep(for: .seconds(1))
                            return ChatMessageModel.mocks.randomElement()!
                        }
                    )
                    .anyButton(.highlight) {
                        onChatPressed(chat: chat)
                    }
                    .removeListRowFormatting()
                }
            }
        } header: {
            Text("chats".uppercased())
        }

    }
    
    // MARK: -- Func --
    private func onChatPressed(chat: ChatModel) {
        path.append(.chat(avatarId: chat.avatarId))
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
    
}

#Preview {
    ChatsView()
}
