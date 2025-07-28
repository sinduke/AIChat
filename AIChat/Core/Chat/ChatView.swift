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
    @State private var currentUser: UserModel? = .mock
    @State private var textFieldText: String = ""
    @State private var scrollViewPosition: String?
    
    @State private var showAlert: AnyAppAlert?
    @State private var showChatSetting: AnyAppAlert?
    
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
        .showCustomAlert(alert: $showAlert)
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSetting)
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
                        imageName: isCurrentUser ? nil : avatar?.profileImageName
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
            .padding(12)
            .padding(.trailing, 60)
            .overlay(alignment: .trailing, content: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 5)
                    .foregroundStyle(.accent)
                    .anyButton {
                        onSendMessageButtonPressed()
                    }
                    .disabled(textFieldText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            })
        
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(.systemBackground))
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.gray.opacity(0.5), lineWidth: 1)
                        
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.secondarySystemBackground))
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
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
