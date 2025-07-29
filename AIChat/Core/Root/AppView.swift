//
//  AppView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct AppView: View {
    @State var appState = AppState()
    @Environment(\.authService) private var authService
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
    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            // 已认证
            print("已认证用户 用户ID为: \(user.uid)")
        } else {
            // 未认证
            do {
                print("未认证用户 ---> 执行登录程序")
                let authResult = try await authService.signInAnonymously()
                print("登录成功 用户ID为: \(authResult.user.uid)")
            } catch {
                print("登录失败 \(error.localizedDescription)")
            }
        }
    }
    
}

#Preview("OnboardingView") {
    AppView(appState: AppState(showTabBar: false))
}

#Preview("TabbarView") {
    AppView(appState: AppState(showTabBar: true))
}
