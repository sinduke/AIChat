//
//  AppView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct AppView: View {
    @AppStorage("showTabbarView") var showTabBar: Bool = false
    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
        })
        .onTapGesture {
            showTabBar.toggle()
        }
    }
}

#Preview("OnboardingView") {
    @Previewable @AppStorage("showTabbarView") var showTabBar: Bool = true
    AppView(showTabBar: showTabBar)
}

#Preview("TabbarView") {
    @Previewable @AppStorage("showTabbarView") var showTabBar: Bool = false
    AppView(showTabBar: showTabBar)
}
