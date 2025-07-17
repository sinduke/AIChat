//
//  TabBarView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("首页", systemImage: "eyes")
                }
            ChatsView()
                .tabItem {
                    Label("对话", systemImage: "bubble.left.and.bubble.right.fill")
                }
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    TabBarView()
}
