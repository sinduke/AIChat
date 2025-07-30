//
//  SignInWithAppleButtonView.swift
//  AIChat
//
//  Created by sinduke on 7/24/25.
//

import SwiftUI
internal import AuthenticationServices

struct SignWithAppleButtonSwiftUIView: View {
    
    var type: SignInWithAppleButton.Label
    let style: SignInWithAppleButton.Style
    let cornerRadius: CGFloat
    
    var onRequest: ((ASAuthorizationAppleIDRequest) -> Void)?
    var onSuccess: ((ASAuthorization) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    init(
        type: SignInWithAppleButton.Label = .signIn,
        style: SignInWithAppleButton.Style = .black,
        cornerRadius: CGFloat = 10,
        onRequest: ((ASAuthorizationAppleIDRequest) -> Void)? = nil,
        onSuccess: ((ASAuthorization) -> Void)? = nil,
        onFailure: ((Error) -> Void)? = nil
    ) {
        self.type = type
        self.style = style
        self.cornerRadius = cornerRadius
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
    
    var body: some View {
        SignInWithAppleButton(type) { request in
            onRequest?(request)
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                onSuccess?(authorization)
                
            case .failure(let error):
                onFailure?(error)
            }
        }
        .cornerRadius(cornerRadius)
    }
}

struct SignInWithAppleButtonView: View {
    
    public let type: ASAuthorizationAppleIDButton.ButtonType
    public let style: ASAuthorizationAppleIDButton.Style
    public let cornerRadius: CGFloat
    
    public init(
        type: ASAuthorizationAppleIDButton.ButtonType = .signIn,
        style: ASAuthorizationAppleIDButton.Style = .black,
        cornerRadius: CGFloat = 10
    ) {
        self.type = type
        self.style = style
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        ZStack {
            Color.clear.opacity(0.001)
            SignInWithAppleButtonViewRepresentable(
                type: type,
                style: style,
                cornerRadius: cornerRadius
            )
//            Xcode26之后 在这个按钮上添加禁用之后 anyButton并不会相应点击事件
            .disabled(true)
            .tappableContentShape()
        }
    }
}

private struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    let cornerRadius: CGFloat
    
    func makeUIView(context: Context) -> some UIView {
        let button = ASAuthorizationAppleIDButton(type: type, style: style)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = cornerRadius
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeCoordinator() {

    }
    
}

#Preview {
    ZStack {
        Color.indigo.ignoresSafeArea()
        VStack(spacing: 16) {
            SignInWithAppleButtonView(
                type: .signIn,
                style: .white,
                cornerRadius: 30
            )
            .frame(height: 55)
            
            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 30
            )
            .frame(height: 55)
            
            SignInWithAppleButtonView(
                type: .signUp,
                style: .white,
                cornerRadius: 10
            )
            .frame(height: 55)
            
            SignInWithAppleButtonView(
                type: .signUp,
                style: .black,
                cornerRadius: 10
            )
            .frame(height: 55)
            
            SignWithAppleButtonSwiftUIView(
                type: .continue,
                style: .white,
                cornerRadius: 10) { auth in
                    print("✅ 登录成功: \(auth)")
                } onFailure: { error in
                    print("❌ 登录失败: \(error)")
                }
                .frame(height: 55)
            
            SignWithAppleButtonSwiftUIView(
                type: .signUp,
                style: .black,
                cornerRadius: 10) { auth in
                    print("✅ 登录成功: \(auth)")
                } onFailure: { error in
                    print("❌ 登录失败: \(error)")
                }
                .frame(height: 55)
        }
        .padding(40)
    }
}
