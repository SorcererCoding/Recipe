//
//  Recipes.swift
//  RecipeTakeHome
//

import SwiftUI

struct Recipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable{
    let cuisineType: String
    let name: String
    let smallPhotoURL: String
    let sourceURL: String?
    let id: String
    let youtubeURL: String?
    var image: UIImage?
    
    
    enum CodingKeys: String, CodingKey {
        case cuisineType = "cuisine"
        case name
        case smallPhotoURL = "photo_url_small"
        case sourceURL = "source_url"
        case id = "uuid"
        case youtubeURL = "youtube_url"
    }
}

