//
//  ChatView.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

struct ChatView: View {
    
    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel? = .mock
    @State private var currentUser: UserModel? = .mock
    @State private var textFieldText: String = ""
    @State private var scrollViewPosition: String?
    
    @State private var showAlert: AnyAppAlert?
    @State private var showChatSetting: AnyAppAlert?
    @State private var showProfileModal: Bool = false
    
    var avatarId: String = AvatarModel.mock.avatarId
    
    var body: some View {
        VStack(spacing: 0) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .padding(8)
                    .anyButton {
                        onChatSettingButtonPressed()
                    }
            }
        }
        .toolbarVisibility(.hidden, for: .tabBar)
        .showCustomAlert(alert: $showAlert)
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSetting)
        .showModal(showModal: $showProfileModal) {
            if let avatar {
                profileModal(avatar: avatar)
            }
        }
    }
    
    // MARK: -- View --
    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(chatMessages) { message in
                    let isCurrentUser = message.authorId == currentUser?.userId
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        imageName: isCurrentUser ? nil : avatar?.profileImageName,
                        onImagePressed: onAvatarImagePressed
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrollViewPosition, anchor: .center)
        .animation(.default, value: chatMessages.count)
        .animation(.default, value: scrollViewPosition)
    }
    
    private var textFieldSection: some View {
        TextField("Text here...", text: $textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .chatInputStyle(text: $textFieldText, onSend: onSendMessageButtonPressed)
    }
    
    private func profileModal(avatar: AvatarModel) -> some View {
        ProfileModalView(
            imageName: avatar.profileImageName,
            title: avatar.name,
            subtitle: avatar.characterOption?.rawValue.capitalized,
            headline: avatar.characterDescription,
            onXmarkPressed: {
                showProfileModal = false
            }
        )
        .padding(40)
        .transition(.slide)
    }
    
    // MARK: -- Func --
    private func onSendMessageButtonPressed() {
        guard let currentUser else { return }
        
        let content = textFieldText
        
        do {
            try TextValidationHelper.validate(content, minLength: 4)
            
            let message = ChatMessageModel(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                authorId: currentUser.userId,
                content: content,
                seenByIds: nil,
                dateCreated: .now
            )
            
            chatMessages.append(message)
            scrollViewPosition = message.id
            
            textFieldText = ""
        } catch let error {
            showAlert = AnyAppAlert(error: error)
        }
    }
    
    private func onChatSettingButtonPressed() {
        
        showChatSetting = AnyAppAlert(
            title: "",
            subtitle: "What would you like to do?",
            buttons: {
                AnyView(
                    Group {
                        Button("Report Chat/User", role: .destructive) {
                            
                        }
                        Button("Delete", role: .destructive) {
                            
                        }
                    }
                )
            }
        )
    }
    
    private func onAvatarImagePressed() {
        showProfileModal = true
    }
}

extension View {
    func chatInputStyle(
        text: Binding<String>,
        onSend: @escaping () -> Void
    ) -> some View {
        self.modifier(ChatTextFieldStyle(text: text, onSend: onSend))
    }
}

struct ChatTextFieldStyle: ViewModifier {
    @Binding var text: String
    var onSend: () -> Void

    func body(content: Content) -> some View {
        content
            .padding(12)
            .padding(.trailing, 60)
            .overlay(alignment: .trailing) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 5)
                    .foregroundStyle(.accent)
                    .opacity(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.3 : 1.0)
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .onTapGesture {
                        onSend()
                    }
            }
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color(.systemBackground))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.secondarySystemBackground))
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
