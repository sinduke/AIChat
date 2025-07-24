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
    
    @ViewBuilder
    func redactedIfLoading(_ isLoading: Bool) -> some View {
        if isLoading {
            self.redacted(reason: .placeholder)
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
}
