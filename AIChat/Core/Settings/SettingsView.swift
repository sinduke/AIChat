//
//  SettingsView.swift
//  AIChat
//
//  Created by sinduke on 7/18/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            List {
                Button {
                    onSignOutButtonPressed()
                } label: {
                    Text("Sign Out")
                }
            }
            .navigationTitle("Settings")
        }
    }

    private func onSignOutButtonPressed() {
        dismiss()
        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateViewState(showTabBarView: false)
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
