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
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    @State private var showAlert: AnyAppAlert?
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
            .sheet(isPresented: $showCreateAccountView, onDismiss: {
                setAnonymousAccountState()
            }, content: {
                CreateAccountView()
                    .presentationDetents([.medium])
            })
            .onAppear {
                setAnonymousAccountState()
            }
        }
        .showCustomAlert(alert: $showAlert)
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
                    onDeleteAccountPressed()
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
        Task {
            do {
                try authManager.signOut()
                userManager.signOut()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    private func dismissScreen() async {
        dismiss()
        try? await Task.sleep(for: .seconds(1))
        appState.updateViewState(showTabBarView: false)
    }
    
    private func onCreateAccountPressed() {
        showCreateAccountView = true
    }
    
    private func setAnonymousAccountState() {
        isAnonymousUser = authManager.auth?.isAnonymous ?? true
    }
    
    private func onDeleteAccountPressed() {
        showAlert = AnyAppAlert(
            title: "Delete Account?",
            subtitle: "This action cannot be undone. All your data will be permanently deleted.",
            buttons: {
                AnyView(
                    Group {
                        Button("Delete", role: .destructive) {
                            onDeleteAccountConfirmed()
                        }
                        
                        Button(role: .cancel) {
                            showAlert = nil
                        }
                    }
                )
            }
        )
    }
    
    private func onDeleteAccountConfirmed() {
        Task {
            do {
                try await authManager.deleteAccount()
                try await userManager.deleteCurrentUser()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
}

#Preview("NoAuth") {
    SettingsView()
        .environment(AppState())
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(service: MockUserService()))
}

#Preview("匿名SettingsView") {
    SettingsView()
        .environment(AppState())
        .environment(AuthManager(service: MockAuthService(user: .mock(isAnonymous: true))))
        .environment(UserManager(service: MockUserService()))
}

#Preview("非匿名SettingsView") {
    SettingsView()
        .environment(AppState())
        .environment(AuthManager(service: MockAuthService(user: .mock(isAnonymous: false))))
        .environment(UserManager(service: MockUserService()))
}
