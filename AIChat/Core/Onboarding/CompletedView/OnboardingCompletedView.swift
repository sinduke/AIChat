//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var root
    @State private var isCompletingProfileSetup: Bool = false
    var selectedColor: Color = .teal
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Setup Complete!")
                .font(.largeTitle)
                .foregroundStyle(selectedColor)
                .fontWeight(.semibold)
            Text("We've set up profile and you're ready to start chatting!")
                .font(.title)
                .fontWeight(.medium)

        }
        .frame(maxHeight: .infinity )
        .safeAreaInset(edge: .bottom, content: {
            ctaButton
        })
        .padding(16)
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: -- view
    private var ctaButton: some View {
        ZStack {
            if isCompletingProfileSetup {
                ProgressView()
                    .tint(.white)
            } else {
                Text("Finish")
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            onFinishedButtonPressed()
        }
        .disabled(isCompletingProfileSetup)
    }

    // MARK: -- func
    private func onFinishedButtonPressed() {
        isCompletingProfileSetup = true
        Task {
            // 模拟储存用户选择颜色之后的保存
            try await Task.sleep(for: .seconds(2))
            isCompletingProfileSetup = false
            root.updateViewState(showTabBarView: true)
        }
    }

}

#Preview {
    OnboardingCompletedView(selectedColor: .orange)
        .environment(AppState())
}
