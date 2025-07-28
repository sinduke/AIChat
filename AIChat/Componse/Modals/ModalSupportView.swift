//
//  ModalSupportView.swift
//  AIChat
//
//  Created by sinduke on 7/28/25.
//

import SwiftUI

struct ModalSupportView<Content: View>: View {
    @Binding var showModal: Bool
    @ViewBuilder var content: Content
    var body: some View {
        ZStack {
            if showModal {
                Color.gray.opacity(0.7).ignoresSafeArea()
                    .transition(AnyTransition(.opacity.animation(.smooth)))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }
}

extension View {
    func showModal(showModal: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
        self
            .overlay {
                ModalSupportView(showModal: showModal, content: {
                    content()
                })
            }
    }
}

private struct PreviewModalView: View {
    @State private var showModal: Bool = false
    var body: some View {
        ZStack {
            Button("Click Me") {
                showModal = true
            }
            .padding()
            .tappableContentShape()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .showModal(showModal: $showModal) {
                RoundedRectangle(cornerRadius: 16)
                    .padding(40)
                    .padding(.vertical, 100)
                    .onTapGesture {
                        showModal = false
                    }
                    .transition(.slide.animation(.bouncy))
            }
        }
    }
}

#Preview {
    PreviewModalView()
}
