//
//  AnyAppAlert.swift
//  AIChat
//
//  Created by sinduke on 7/28/25.
//

import SwiftUI


struct AnyAppAlert: Sendable {
    var title: String
    var subtitle: String?
    var buttons: () -> AnyView
    
    init(title: String, subtitle: String? = nil, buttons: (() -> AnyView)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("OK", action: {
                    
                })
            )
        }
    }
    
    init(error: Error) {
        self.init(title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }
}

enum AppAlertStyle {
    case alert, confirmationDialog
}

extension View {
    @ViewBuilder
    func showCustomAlert(type: AppAlertStyle = .alert, alert: Binding<AnyAppAlert?>) -> some View {
        switch type {
        case .alert:
            self
                .alert(
                    alert.wrappedValue?.title ?? "",
                    isPresented: Binding(isNotNil: alert)
                ) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
            
        case .confirmationDialog:
            self
                .confirmationDialog(alert.wrappedValue?.title ?? "", isPresented: Binding(isNotNil: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        }
        
    }
}
