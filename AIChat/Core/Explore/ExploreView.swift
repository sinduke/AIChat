//
//  ExploreView.swift
//  AIChat
//
//  Created by sinduke on 7/17/25.
//

import SwiftUI

struct ExploreView: View {
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var featureAvatars: [AvatarModel] = AvatarModel.mocks
    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection
            }
            .navigationTitle("Explore".uppercased())
        }
    }

    // MARK: -- View --
    private var featuredSection: some View {
        Section {
            CarouselView(items: featureAvatars) { avatar in
                HeroCellView(
                    title: avatar.name,
                    subTitle: avatar.characterDescription,
                    imageName: avatar.profileImageName
                )
            }
        } header: {
            Text("Featured Avatars")
        }
        .removeListRowFormatting()
    }

    private var categorySection: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(categories) { category in
                        CategoryCellView(
                            title: category.rawValue.capitalized,
                            imageName: Constants.randomImages
                        )
                    }
                }
            }
            .frame(height: 140)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
        } header: {
            Text("Categories".uppercased())
        }
        .removeListRowFormatting()
    }
}

#Preview {
    ExploreView()
}
