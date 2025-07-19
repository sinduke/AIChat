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
            Group {
                Text("Make your own ")
                +
                Text("avatars ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("and chat with them. \n\nHave ")
                +
                Text("real conversation ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("with AI generated response.")
            }
            .frame(maxHeight: .infinity)
            .baselineOffset(6)
            .padding(24)

            NavigationLink {
                OnboardingColorView()
            } label: {
                Text("Continue")
                    .callToActionButton()
            }
        }
        .padding(24)
        .font(.title3)
    }
}

#Preview {
    OnboardingIntroView()
}
