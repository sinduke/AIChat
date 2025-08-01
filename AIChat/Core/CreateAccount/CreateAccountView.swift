//
//  CreateAccountView.swift
//  AIChat
//
//  Created by sinduke on 7/24/25.
//

import SwiftUI
internal import AuthenticationServices

struct CreateAccountView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(\.dismiss) private var dismiss
    var title: String = "Create Account?"
    var subTitle: String = "Don't lost your data! Connect to an SSO provider to save your Account."
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 10
            )
            .frame(height: 55)
            .anyButton(.press) {
                print("点击了Apple登录按钮")
                onSignInAppleButtonPressed()
            }
            
            Spacer(minLength: 30)
        }
        .padding(16)
        .padding(.top, 40)
    }
    
    // MARK: -- Func --
    private func onSignInAppleButtonPressed() {
        Task {
            do {
                let result = try await authManager.signInApple()
                print("成功使用Apple登录 \(result.isNewUser)")
                onDidSignIn?(result.isNewUser)
                dismiss()
            } catch {
                print("Apple登录失败: \(error.localizedDescription)")
            }
        }
    }
    
}

#Preview {
    CreateAccountView()
}
