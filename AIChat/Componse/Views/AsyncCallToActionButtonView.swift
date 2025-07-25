//
//  AsyncCallToActionButtonView.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

struct AsyncCallToActionButtonView: View {
    var isLoading: Bool = false
    var title: String = "Save"
    var action: () -> Void
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            action()
        }
        .disabled(isLoading)
    }
}

// swiftlint:disable:next private_over_fileprivate
fileprivate struct PreviewAsyncButtonBuilder: View {
    @State private var isLoading: Bool = false
    var body: some View {
        AsyncCallToActionButtonView(
            isLoading: isLoading,
            title: "Finish",
            action: {
                isLoading = true
                Task {
                    try? await Task.sleep(for: .seconds(3))
                    isLoading = false
                }
            }
        )
    }
}

#Preview {
    PreviewAsyncButtonBuilder()
        .padding()
}
