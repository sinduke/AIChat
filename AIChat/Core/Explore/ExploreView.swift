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
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                featuredSection
                categorySection
                popularSection
            }
            .navigationTitle("Explore")
            .navigationDestinationForCoreModule(path: $path)
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
                    onAvatarPressed(avatar: avatar)
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
                        let imageName = populars.first(where: { $0.characterOption == category})?.profileImageName
                        if let imageName {
                            CategoryCellView(
                                title: category.plural.capitalized,
                                imageName: imageName
                            )
                            .anyButton {
                                onCategoryPressed(category: category, imageName: imageName)
                            }
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
            ForEach(populars) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subTitle: avatar.characterDescription
                )
                .anyButton(.highlight) {
                    onAvatarPressed(avatar: avatar)
                }
            }
        } header: {
            Text("Popular")
        }
        .removeListRowFormatting()
    }
    
    // MARK: -- Func --
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
    
    private func onCategoryPressed(category: CharacterOption, imageName: String) {
        path.append(.category(category: category, imageName: imageName))
    }
    
}

#Preview {
    ExploreView()
}
