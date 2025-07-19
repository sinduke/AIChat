//
//  HeroCellView.swift
//  AIChat
//
//  Created by sinduke on 7/19/25.
//

import SwiftUI

struct HeroCellView: View {
    var title: String? = "This is some Title."
    var subTitle: String? = "This is some description."
    var imageName: String? = Constants.randomImages

    var body: some View {
        ZStack {
            if let imageName {
                ImageLoaderView(urlString: imageName)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.5))
            }
        }
        .overlay(alignment: .bottomLeading, content: {
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                if let subTitle {
                    Text(subTitle)
                        .font(.subheadline)
                }
            }
            .foregroundStyle(.white)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(colors: [
                    .black.opacity(0),
                    .black.opacity(0.3),
                    .black.opacity(0.4)
                ], startPoint: .top, endPoint: .bottom)
            )
        })
        .cornerRadius(16)
    }
}

#Preview {
    ScrollView {
        HeroCellView()
            .frame(width: 300, height: 200)
        HeroCellView()
            .frame(width: 400, height: 200)
        HeroCellView()
            .frame(width: 200, height: 400)
        HeroCellView(imageName: nil)
            .frame(width: 300, height: 200)
        HeroCellView(title: nil)
            .frame(width: 300, height: 200)
        HeroCellView(subTitle: nil)
            .frame(width: 300, height: 200)
    }
    .frame(maxWidth: .infinity)
}
