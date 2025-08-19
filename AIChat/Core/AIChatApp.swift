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
    var dependencies: Dependencies!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions languageOption: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        dependencies = Dependencies()
        
        return true
    }
}

@main
struct AIChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.dependencies.userManager)
                .environment(delegate.dependencies.authManager)
                .environment(delegate.dependencies.aiManager)
        }
    }
}

// @MainActor
struct Dependencies {
    let userManager: UserManager
    let authManager: AuthManager
    let aiManager: AIManager
    
    init() {
        userManager = UserManager(service: ProductionUserServices())
        authManager = AuthManager(service: FirebaseAuthService())
        aiManager = AIManager(service: OpenAIService())
    }
    
}
