//
//  WelcomeView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome View")
                    .frame(maxHeight: .infinity)

                NavigationLink {
                    OnboardingCompletedView()
                } label: {
                    Text("Get Start")
                        .callToActionButton()
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    WelcomeView()
}
