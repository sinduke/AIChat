//
//  View+EXT.swift
//  AIChat
//
//  Created by sinduke on 7/18/25.
//

import SwiftUI

extension View {
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.accent)
            .clipShape(.rect(cornerRadius: 16, style: .continuous))
    }

    func tappableContentShape() -> some View {
        contentShape(Rectangle())
    }

    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }

    func addGradientBackgroundForText() -> some View {
        background(
            LinearGradient(colors: [
                .black.opacity(0),
                .black.opacity(0.3),
                .black.opacity(0.4)
            ], startPoint: .top, endPoint: .bottom)
        )
    }
    
    /**
     .if(...) 会导致生成两个结构不同的视图树，SwiftUI diff 算法可能出现重建、闪烁、动画问题
     .if(...) 中的条件是 静态不变 或 外部不依赖状态，可以接受。
     .if(...) 工具方法用于“开发环境、样式静态切换、调试”等用途，但在 动态变化的状态驱动视图中，建议改为 ViewModifier 或 Group 的方式，以确保性能与动画的稳定性。
     */
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func rowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(.systemBackground))
    }
    
    func badgeButtonStyle() -> some View {
        self
            .font(.caption)
            .bold()
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(.blue)
            .clipShape(.rect(
                topLeadingRadius: 12,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 12,
                topTrailingRadius: 0,
                style: .continuous
            ))
    }
    
    func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissKeyboardOnTap())
    }
}

struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .gesture(
                TapGesture()
                    .onEnded {
                        FocusStateUtils.resignFocus()
                    }
            )
    }
}

enum FocusStateUtils {
    private static var currentUnfocus: (() -> Void)?

    static func bind(_ unfocus: @escaping () -> Void) {
        currentUnfocus = unfocus
    }

    static func resignFocus() {
        currentUnfocus?()
    }
}
