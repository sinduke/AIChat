//
//  CategoryCellView.swift
//  AIChat
//
//  Created by sinduke on 7/22/25.
//

import SwiftUI

struct CategoryCellView: View {
    var title: String = "Aliens"
    var imageName: String = Constants.randomImages
    var font: Font = .title2
    var cornerRadius: CGFloat = 16

    var body: some View {
        ImageLoaderView(urlString: imageName)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                Text(title)
                    .font(font)
                    .fontWeight(.semibold)
                    .padding(16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [
                            .black.opacity(0),
                            .black.opacity(0.3),
                            .black.opacity(0.4)
                        ], startPoint: .top, endPoint: .bottom)
                    )
            }
            .cornerRadius(cornerRadius)
    }
}

#Preview {
    VStack {
        CategoryCellView()
            .frame(height: 150)

        CategoryCellView()
            .frame(height: 350)
    }
}
