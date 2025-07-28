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
    @State private var populars: [AvatarModel] = AvatarModel.mocks
    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection
                popularSection
            }
            .navigationTitle("Explore")
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
                .anyButton(.plain) {

                }
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
                            title: category.plural.capitalized,
                            imageName: Constants.randomImages
                        )
                        .anyButton {

                        }
                    }
                }
            }
            .frame(height: 140)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
        } header: {
            Text("Categories")
        }
        .removeListRowFormatting()
    }

    private var popularSection: some View {
        Section {
            ForEach(populars) { popular in
                CustomListCellView(
                    imageName: popular.profileImageName,
                    title: popular.name,
                    subTitle: popular.characterDescription
                )
                .anyButton(.highlight) {

                }
            }
        } header: {
            Text("Popular")
        }
        .removeListRowFormatting()
    }
}

#Preview {
    ExploreView()
}
