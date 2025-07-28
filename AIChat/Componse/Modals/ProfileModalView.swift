//
//  ProfileModalView.swift
//  AIChat
//
//  Created by sinduke on 7/28/25.
//

import SwiftUI

struct ProfileModalView: View {
    var imageName: String? = Constants.randomImages
    var title: String? = "Alpha"
    var subtitle: String? = "Alien"
    var headline: String? = "Alien reading in the space"
    var onXmarkPressed: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageName {
                ImageLoaderView(urlString: imageName, forceTransitionAnimation: true)
                    .aspectRatio(1, contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16, style: .continuous))
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(.black)
                .padding(4)
                .tappableContentShape()
                .anyButton {
                    onXmarkPressed()
                }
                .padding()
        }
    }
}

#Preview("Modal With Image") {
    ZStack {
        Color.mint.opacity(0.5).ignoresSafeArea()
        
        ProfileModalView()
            .padding(40)
    }
}

#Preview("Modal Without Image") {
    ZStack {
        Color.mint.opacity(0.5).ignoresSafeArea()
        
        ProfileModalView(imageName: nil)
            .padding(40)
    }
}
