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
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("TabbarView")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("OnboardingView")
                }
        })
    }
}

#Preview("OnboardingView") {
    AppView()
}

#Preview("TabbarView") {
    AppView(showTabBar: true)
}
