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
        self
            .contentShape(Rectangle())
    }
}
