//
//  ChatRowCellView.swift
//  AIChat
//
//  Created by sinduke on 7/23/25.
//

import SwiftUI

struct ChatRowCellView: View {
    
    var imageName: String? = Constants.randomImages
    var title: String? = "Alpha"
    var subTitle: String? = "This is the last chat in the message"
    var hasNewMessage: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                if let subTitle {
                    Text(subTitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if hasNewMessage {
                Text("NEW")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(.blue)
                    .clipShape(.rect(
                        topLeadingRadius: 12,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 12,
                        topTrailingRadius: 0,
                        style: .continuous
                    ))
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.5).ignoresSafeArea()
        List {
            Section {
                ChatRowCellView()
                ChatRowCellView(hasNewMessage: true)
                ChatRowCellView(imageName: nil)
                ChatRowCellView(title: nil)
                ChatRowCellView(subTitle: nil)
                ChatRowCellView(subTitle: nil, hasNewMessage: true)
            }
            .removeListRowFormatting()
        }
    }
}
