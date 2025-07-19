//
//  OnboardingIntroView.swift
//  AIChat
//
//  Created by sinduke on 7/18/25.
//

import SwiftUI

struct OnboardingIntroView: View {
    var body: some View {
        VStack {
            Text(makeIntroText())
                .frame(maxHeight: .infinity)


            NavigationLink {
                OnboardingColorView()
            } label: {
                Text("Continue")
                    .callToActionButton()
            }
        }
        .baselineOffset(6)
        .padding(24)
    }

    func makeIntroText() -> AttributedString {
        var result = AttributedString("Make your own ")

        var avatars = AttributedString("avatars ")
        avatars.foregroundColor = .accentColor
        avatars.font = .system(size: UIFont.labelFontSize, weight: .semibold)
        result += avatars

        result += AttributedString("and chat with them.\n\nHave ")

        var real = AttributedString("real conversation ")
        real.foregroundColor = .accentColor
        real.font = .system(size: UIFont.labelFontSize, weight: .semibold)
        result += real

        result += AttributedString("with AI generated response.")

        return result
    }
}

#Preview {
    OnboardingIntroView()
}
