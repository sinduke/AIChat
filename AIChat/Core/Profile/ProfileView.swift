//
//  ProfileView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var showSettingView: Bool = false
    var body: some View {
        NavigationStack {
            Text("ProfileView")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettingView) {
            Text("SettingsView")
        }
    }
    // MARK: -- view --
    private var settingsButton: some View {
        Button {
            onSettingsButtonPressed()
        } label: {
            Image(systemName: "gear")
                .font(.headline)
        }
    }

    // MARK: -- func --
    private func onSettingsButtonPressed() {
        showSettingView = true
    }
}

#Preview {
    ProfileView()
}
