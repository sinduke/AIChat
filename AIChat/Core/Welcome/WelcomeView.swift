//
//  WelcomeView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var imageName: String = Constants.randomImages
    @State private var showSignInView: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()

                titleSection
                    .padding(.top, 24)

                ctaButtons
                    .padding(16)

                privacySection
            }
        }
        .sheet(isPresented: $showSignInView) {
            CreateAccountView(
                title: "Sign In",
                subTitle: "Connect to an existing account."
            )
                .presentationDetents([.medium])
        }
    }

    // MARK: -- View
    private var titleSection: some View {
        VStack {
            Text("AI Chat")
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text("GitHub @ sinduke")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
    }

    private var ctaButtons: some View {
        VStack {
            NavigationLink {
                OnboardingIntroView()
            } label: {
                Text("Get Start")
                    .callToActionButton()
            }

            Text("Already have an account? Sign In")
                .underline()
                .font(.body)
                .padding(8)
                .tappableContentShape()
                .onTapGesture {
                    onSignInButtonPressed()
                }
        }
    }

    private var privacySection: some View {
        HStack {
            Link(destination: URL(string: Constants.termsOfService)!) {
                Text("Terms of service")
            }
            Circle()
                .frame(width: 4, height: 4)
                .foregroundStyle(.accent)
            Link(destination: URL(string: Constants.privacyPolicyURL)!) {
                Text("Privacy Policy")
            }
        }
    }
    
    // MARK: -- Func --
    private func onSignInButtonPressed() {
        showSignInView = true
    }
}

#Preview {
    WelcomeView()
}
