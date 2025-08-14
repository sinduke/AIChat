//
//  AppView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct AppView: View {
    @State var appState = AppState()
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
        })
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, showTabBar in
            if !showTabBar {
                Task {
                    await checkUserStatus()
                }
            } else {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    private func checkUserStatus(maxRetries: Int = 3) async {
        if let user = authManager.auth {
            do {
                try await RetryHelper.retry(maxRetries: 3, maxDelay: 20) {
                    try await userManager.login(auth: user, isNewUser: true)
                }
            } catch {
                print("🚨 登录流程最终失败: \(error.localizedDescription)")
            }
        } else {
            do {
                let authResult = try await authManager.signInAnonymously()
                try await RetryHelper.retry(maxRetries: 3, maxDelay: 20) {
                    try await userManager.login(auth: authResult.user, isNewUser: authResult.isNewUser)
                }
            } catch {
                print("🚨 登录流程最终失败: \(error.localizedDescription)")
            }
        }
    }
    
}

#Preview("OnboardingView") {
    AppView(appState: AppState(showTabBar: false))
        .environment(UserManager(service: MockUserServices(user: .mock)))
        .environment(AuthManager(service: MockAuthService(user: .mock())))
}

#Preview("TabbarView") {
    AppView(appState: AppState(showTabBar: true))
        .environment(UserManager(service: MockUserServices(user: nil)))
        .environment(AuthManager(service: MockAuthService(user: nil)))
}
