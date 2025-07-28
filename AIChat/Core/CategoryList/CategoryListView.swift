//
//  CategoryListView.swift
//  AIChat
//
//  Created by sinduke on 7/28/25.
//

import SwiftUI

struct CategoryListView: View {
    
    var category: CharacterOption = .default
    var imageName: String = Constants.randomImages
    @State private var avatars: [AvatarModel] = AvatarModel.mocks
    
    var body: some View {
        List {
            CategoryCellView(
                title: category.plural.capitalized,
                imageName: imageName,
                font: .largeTitle,
                cornerRadius: 0
            )
            .removeListRowFormatting()
            ForEach(avatars) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subTitle: avatar.characterDescription
                )
            }
            .removeListRowFormatting()
        }
        .listStyle(.plain)
        .ignoresSafeArea()
    }
}

#Preview {
    CategoryListView()
}
