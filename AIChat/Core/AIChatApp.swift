//
//  AIChatApp.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var userManager: UserManager!
    // swiftlint:disable:next implicitly_unwrapped_optional
    var authManager: AuthManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions languageOption: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        userManager = UserManager(service: ProductionUserServices())
        authManager = AuthManager(service: FirebaseAuthService())
        
        return true
    }
}

@main
struct AIChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.userManager)
                .environment(delegate.authManager)
        }
    }
}
