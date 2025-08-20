//
//  CreateAvatarView.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

struct CreateAvatarView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AIManager.self) private var aiManager
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default
    @State private var isGenerating: Bool = false
    @State private var generateImage: UIImage?
    @State private var isSaving: Bool = false
    @State private var showAlert: AnyAppAlert?
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                imageSection
                buttonSection
            }
            .navigationTitle("CreateAvatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButtonView
                }
            }
            .showCustomAlert(alert: $showAlert)
//            .dismissKeyboardOnTap()
            .onAppear {
                FocusStateUtils.bind {
                    isTextFieldFocused = false
                }
            }
        }
    }
    
    // MARK: -- View --
    private var backButtonView: some View {
        Image(systemName: "xmark")
            .font(.title3)
            .foregroundStyle(.accent)
            .fontWeight(.semibold)
            .anyButton(.press) {
                onBackButtonPressed()
            }
    }
    
    private var nameSection: some View {
        Section {
            TextField("Player 1", text: $avatarName)
                .focused($isTextFieldFocused)
        } header: {
            Text("name your avatar*".uppercased())
        }
    }
    
    private var attributesSection: some View {
        Section {
            
            Picker("Select a Option", selection: $characterOption) {
                ForEach(CharacterOption.allCases) { option in
                    Text(option.rawValue.capitalized)
                }
            }
            
            Picker("Select a Action", selection: $characterAction) {
                ForEach(CharacterAction.allCases) { action in
                    Text(action.rawValue.capitalized)
                }
            }
            
            Picker("Select a Location", selection: $characterLocation) {
                ForEach(CharacterLocation.allCases) { location in
                    Text(location.rawValue.capitalized)
                }
            }
            
        } header: {
            Text("Attributes")
        }
    }
    
    private var imageSection: some View {
        Section {
            HStack(alignment: .top) {
                
                Circle()
                    .fill(.gray.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generateImage {
                                Image(uiImage: generateImage)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                    .clipShape(.circle)
                
                ZStack {
                    Text("Create Image")
                        .underline()
                        .foregroundStyle(.accent)
                        .anyButton {
                            onGenerateImageButtonPressed()
                        }
                        .opacity(isGenerating ? 0 : 1)
                    
                    ProgressView()
                        .foregroundStyle(.accent)
                        .opacity(isGenerating ? 1 : 0)
                }
                .disabled(isGenerating || avatarName.isEmpty)
                .padding()
            }
        }
        .removeListRowFormatting()
    }
    
    private var buttonSection: some View {
        Section {
            AsyncCallToActionButtonView(
                isLoading: isSaving,
                title: "Save",
                action: onSaveButtonPressed
            )
            .opacity(generateImage == nil ? 0.5 : 1)
            .disabled(generateImage == nil)
        }
        .removeListRowFormatting()
    }
    
    // MARK: -- Func --
    private func onBackButtonPressed() {
        dismiss()
    }
    
    private func onGenerateImageButtonPressed() {
        isGenerating = true
        Task {
            do {
                let prompt = AvatarDescriptionBuilder(
                    characterOption: characterOption,
                    characterAction: characterAction,
                    characterLocation: characterLocation
                ).avatarDiscription
                
                generateImage = try await aiManager.generateImage(input: prompt)
                
            } catch {
                print("Error generating image: \(error)")
            }
            isGenerating = false
        }
    }
    
    private func onSaveButtonPressed() {
        guard let generateImage else { return }
        isSaving = true
        Task {
            
            do {
                try TextValidationHelper.validate(avatarName, minLength: 3)
                let uid = try authManager.getAuthId()
                
                let avatar = AvatarModel(
                    avatarId: UUID().uuidString,
                    name: avatarName,
                    characterOption: characterOption,
                    characterAction: characterAction,
                    characterLocation: characterLocation,
                    profileImageName: nil,
                    autherId: uid,
                    dateCrerated: .now
                )
                // Upload image to Firebase Storage
                try await avatarManager.createAvatar(avatar: avatar, image: generateImage)
                // dismiss screen
                dismiss()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
            isSaving = false
        }
    }
}

#Preview {
    CreateAvatarView()
        .environment(AIManager(service: MockAIService()))
        .environment(AvatarManager(service: MockAvatarService()))
        .environment(AuthManager(service: MockAuthService(user: .mock())))
}
