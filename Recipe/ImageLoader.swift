//
//  ImageLoader.swift
//  RecipeTakeHome
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var url: String

    init(url: String) {
        self.url = url
        Task {
            do {
                try await loadImage()
            }catch {
                print(error)
            }
        }
    }

    private func loadImage() async throws {
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else { return }
        
        let smallImageRequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: smallImageRequest)
        await MainActor.run {
            guard let image = UIImage(data: data) else { return }
            ImageCache.shared.set(image, forKey: self.url)
            self.image = image
        }
    }
}

