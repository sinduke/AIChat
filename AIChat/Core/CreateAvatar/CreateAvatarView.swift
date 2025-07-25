//
//  CreateAvatarView.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

struct CreateAvatarView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default
    @State private var isGenerating: Bool = false
    @State private var generateImage: UIImage?
    @State private var isSaving: Bool = false
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
            .dismissKeyboardOnTap()
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
            .font(.title)
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
            try? await Task.sleep(for: .seconds(2))
            generateImage = UIImage(systemName: "lasso.badge.sparkles")
            isGenerating = false
        }
    }
    
    private func onSaveButtonPressed() {
        isSaving = true
        Task {
            try? await Task.sleep(for: .seconds(2))
            isSaving = false
            
            dismiss()
        }
    }
}

#Preview {
    CreateAvatarView()
}
