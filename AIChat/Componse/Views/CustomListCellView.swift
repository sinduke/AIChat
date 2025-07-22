//
//  CustomListCellView.swift
//  AIChat
//
//  Created by sinduke on 7/22/25.
//

import SwiftUI

struct CustomListCellView: View {
    var imageName: String? = Constants.randomImages
    var title: String? = "Alpha"
    var subTitle: String? = "An alien that eat in the space!"
    var body: some View {
        HStack {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.3))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 60)
            .cornerRadius(16)

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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .padding(.vertical, 4)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        VStack {
            CustomListCellView()
            CustomListCellView(imageName: nil)
            CustomListCellView(title: nil)
            CustomListCellView(subTitle: nil)
        }
    }
}
