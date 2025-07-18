//
//  AppView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct AppView: View {
    @State var appState = AppState()
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
        .onTapGesture {
            appState.updateViewState(showTabBarView: !appState.showTabBar)
        }
    }
}

#Preview("OnboardingView") {
    AppView(appState: AppState(showTabBar: false))
}

#Preview("TabbarView") {
    AppView(appState: AppState(showTabBar: true))
}
