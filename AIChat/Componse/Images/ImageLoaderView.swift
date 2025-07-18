//
//  ImageLoaderView.swift
//  AIChat
//
//  Created by sinduke on 7/18/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImages
    var resizingModel: ContentMode = .fill
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.progress)
                    .aspectRatio(contentMode: resizingModel)
                    .allowsTightening(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
}
