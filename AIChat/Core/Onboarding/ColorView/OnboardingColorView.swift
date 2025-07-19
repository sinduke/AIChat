//
//  OnboardingColorView.swift
//  AIChat
//
//  Created by sinduke on 7/18/25.
//

import SwiftUI

struct OnboardingColorView: View {
    @State private var selectedColor: Color?
    let profileColors: [Color] = [
        .cyan, .green, .blue, .yellow, .purple, .brown, .indigo, .mint, .teal
    ]
    var body: some View {
        ScrollView {
            colorGrid
                .padding(.horizontal, 24)
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: .zero, content: {
            ZStack {
                if let selectedColor {
                    ctaButton(selectedColor: selectedColor)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .transition(AnyTransition.move(edge: .bottom))
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: [.bottom])
            .background(.ultraThinMaterial)
        })
        .animation(.smooth, value: selectedColor)
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: -- View
    private var colorGrid: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(
                    .flexible(),
                    spacing: 16,
                    alignment: .center
                ),
                count: 3
            ),
            alignment: .center,
            spacing: 16,
            pinnedViews: .sectionHeaders
        ) {
            Section {
                ForEach(profileColors, id: \.self) { color in
                    Circle()
                        .fill(.accent)
                        .overlay(content: {
                            color
                                .clipShape(.circle)
                                .padding(selectedColor == color ? 8 : 0)
                                .animation(.easeIn, value: selectedColor)
                        })
                        .onTapGesture {
                            if selectedColor != color {
                                selectedColor = color
                            } else {
                                selectedColor = nil
                            }
                        }
                }
            } header: {
                Text("Selected a Profile Color")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: -- func
    private func ctaButton(selectedColor: Color) -> some View {
        NavigationLink {
            OnboardingCompletedView(selectedColor: selectedColor)
        } label: {
            Text("Get Start")
                .callToActionButton()
        }
    }
}

#Preview {
    NavigationStack {
        OnboardingColorView()
    }
    .environment(AppState())
}
