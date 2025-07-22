//
//  ButtonViewModifiers.swift
//  AIChat
//
//  Created by sinduke on 7/22/25.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .overlay {
                configuration.isPressed ? Color.accentColor.opacity(0.4) : Color.clear.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

enum ButtonStyleAction {
    case highlight, press, plain
}

extension View {

    @ViewBuilder
    func anyButton(_ option: ButtonStyleAction = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .highlight:
            highlightButton(action: action)

        case .press:
            pressableButton(action: action)

        case .plain:
            plainButton(action: action)
        }

    }

    private func plainButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(.plain)
    }

    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }

    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    VStack {

        Text("HighLight")
            .padding()
            .frame(maxWidth: .infinity)
            .tappableContentShape()
            .anyButton(.highlight, action: {

            })
            .padding()

        Text("Pressable")
            .callToActionButton()
            .anyButton(.press, action: {

            })
            .padding()

        Text("Plain")
            .callToActionButton()
            .anyButton(action: {

            })
            .padding()
    }
}
