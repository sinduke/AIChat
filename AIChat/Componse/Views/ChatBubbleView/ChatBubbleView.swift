//
//  ChatBubbleView.swift
//  AIChat
//
//  Created by sinduke on 7/25/25.
//

import SwiftUI

struct ChatBubbleView: View {
    var text: String = "This is sample text."
    var textColor: Color = .primary
    var backgroundColor: Color = Color(.systemGray5)
    var showImage: Bool = true
    var imageName: String?
    let offset: CGFloat = 14
    
    var body: some View {
        HStack(alignment: .top) {
            if showImage {
                ZStack {
                    if let imageName {
                        ImageLoaderView(urlString: imageName)
                    } else {
                        Rectangle()
                            .fill(.secondary)
                    }
                }
                .frame(width: 45, height: 45)
                .clipShape(.circle)
                .offset(y: offset)
            }
            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: 6))
        }
        .padding(.bottom, showImage ? offset : 0)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ChatBubbleView(showImage: false)
            ChatBubbleView(text: "This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text.")
            ChatBubbleView(
                text: "This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text.",
                textColor: .white,
                backgroundColor: .accent,
                showImage: false,
                imageName: nil
            )
            ChatBubbleView(
                text: "This is a short text.",
                textColor: .white,
                backgroundColor: .accent,
                imageName: nil
            )
        }
    }
    .padding(8)
}
