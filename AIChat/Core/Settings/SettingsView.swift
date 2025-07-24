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
    
    @State private var isPremium: Bool = false
    @State private var isAnonymousUser: Bool = true
    @State private var showCreateAccountView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchasesSection
                applicationSection
            }
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle("IsPremium", isOn: $isAnonymousUser)
                }
            })
            .sheet(isPresented: $showCreateAccountView) {
                CreateAccountView()
                    .presentationDetents([.medium])
            }
        }
    }
    
    // MARK: -- View --
    private var accountSection: some View {
        Section {
            if isAnonymousUser {
                Text("Save & Back-up Account")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onCreateAccountPressed()
                    }
            } else {
                Text("Sign Out")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onSignOutButtonPressed()
                    }
            }
                
            
            Text("Delete Account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(.highlight) {
                    
                }
        } header: {
            Text("Account")
        }
        .removeListRowFormatting()
    }
    
    private var purchasesSection: some View {
        Section {
            HStack {
                Text("Account state: \(isPremium ? "Premium" : "Free")")
                Spacer(minLength: 20)
                if isPremium {
                    Text("Manager")
                        .badgeButtonStyle()
                }
            }
            .rowFormatting()
            .anyButton(.highlight) {
                
            }
            .disabled(!isPremium)
        } header: {
            Text("Purchases")
        }
        .removeListRowFormatting()
    }
    
    private var applicationSection: some View {
        Section {
            HStack {
                Text("Version")
                Spacer(minLength: 20)
                Text(Utilities.appVersion ?? "nil")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            
            HStack {
                Text("Build Number")
                Spacer(minLength: 20)
                Text(Utilities.buildNumber ?? "nil")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            
            Text("Contact us")
                .foregroundStyle(.blue)
                .rowFormatting()
                .anyButton(.highlight) {
                    
                }
                
        } header: {
            Text("Application")
        } footer: {
            Text("Created By Sinduke.\n github: https://github.com/sinduke/AIChat")
                .baselineOffset(8)
                .frame(maxWidth: .infinity)
                .padding()
                .multilineTextAlignment(.center)
        }
        .removeListRowFormatting()
    }
    
    // MARK: -- func --
    private func onSignOutButtonPressed() {
        dismiss()
        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateViewState(showTabBarView: false)
        }
    }
    
    private func onCreateAccountPressed() {
        showCreateAccountView = true
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
