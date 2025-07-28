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
    var forceRefresh: Bool = false  // ✅ 新增控制参数
    var forceTransitionAnimation: Bool = false
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                WebImage(url: URL(string: urlString), options: forceRefresh ? [.refreshCached] : [])
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingModel)
                    .allowsTightening(false)
                    .if(forceTransitionAnimation) { $0.drawingGroup() }
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
}
