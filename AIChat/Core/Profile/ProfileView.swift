//
//  ProfileView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(UserManager.self) private var userManager
    
    @State private var showSettingView: Bool = false
    @State private var showCreateAvatarView: Bool = false
    @State private var currentUser: UserModel?
    @State private var myAvatars: [AvatarModel] = []
    @State private var isLoading: Bool = false
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                myInfoSection
                avatarSection
            }
            .navigationTitle("Profile")
            .navigationDestinationForCoreModule(path: $path)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
        }
        .task {
            await loadData()
        }
        .sheet(isPresented: $showSettingView) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showCreateAvatarView) {
            CreateAvatarView()
        }
    }
    // MARK: -- view --
    private var settingsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.accent)
            .anyButton {
                onSettingsButtonPressed()
            }
    }
    
    private var myInfoSection: some View {
        Section {
            ZStack {
                Circle()
                    .fill(currentUser?.profileColorCalculated ?? .accent)
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .removeListRowFormatting()
    }
    
    private var avatarSection: some View {
        Section {
            if myAvatars.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Click + Button to Create Avatar")
                    }
                }
                .font(.body)
                .padding(50)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.secondary)
            } else {
                ForEach(myAvatars) { avatar in
                    CustomListCellView(
                        imageName: avatar.profileImageName,
                        title: avatar.name,
                        subTitle: avatar.characterDescription
                    )
                    .anyButton(.highlight) {
                        onAvatarPressed(avatar: avatar)
                    }
                }
                .onDelete { indexSet in
                    onDeleteAvatar(indexSet: indexSet)
                }
            }
        } header: {
            HStack {
                Text("my avatars".uppercased())
                Spacer(minLength: 30)
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(.accent)
                    .anyButton(.plain) {
                        onNewAvatarButtonPressed()
                    }
            }
            .padding()
        }
        .removeListRowFormatting()
    }

    // MARK: -- func --
    private func onSettingsButtonPressed() {
        showSettingView = true
    }
    
    private func onNewAvatarButtonPressed() {
        showCreateAvatarView = true
    }
    
    private func onDeleteAvatar(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        myAvatars.remove(at: index)
    }
    
    private func loadData() async {
        isLoading = true
        self.currentUser = userManager.currentUser
        isLoading = false
        myAvatars = AvatarModel.mocks
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
        .environment(UserManager(service: MockUserService(user: .mock)))
}
