//
//  CreateAccountView.swift
//  AIChat
//
//  Created by sinduke on 7/24/25.
//

import SwiftUI
internal import AuthenticationServices

struct CreateAccountView: View {
    
    var title: String = "Create Account?"
    var subTitle: String = "Don't lost your data! Connect to an SSO provider to save your Account."
    
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
                print("点击了登录按钮")
            }
            
            Spacer(minLength: 30)
        }
        .padding(16)
        .padding(.top, 40)
    }
}

#Preview {
    CreateAccountView()
}
