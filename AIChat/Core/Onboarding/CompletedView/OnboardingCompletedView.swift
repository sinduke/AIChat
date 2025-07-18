//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var root
    var body: some View {
        VStack {
            Text("Onboarding Completed")
                .frame(maxHeight: .infinity)

            Button {
                onFinishedButtonPressed()
            } label: {
                Text("Finish")
                    .callToActionButton()
            }
        }
        .padding(16)
    }

    private func onFinishedButtonPressed() {
        root.updateViewState(showTabBarView: true)
    }

}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
