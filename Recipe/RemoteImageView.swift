//
//  RemoteImageView.swift
//  RecipeTakeHome

import SwiftUI

struct RemoteImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 150, height: 120)
                .scaledToFill()
        } else {
            ProgressView()
        }
    }
}

