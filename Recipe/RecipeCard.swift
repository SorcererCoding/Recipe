//
//  RecipeCard.swift
//  RecipeTakeHome


import SwiftUI

struct RecipeCard: View {
    var recipe: Recipe
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .center) {
                RemoteImageView(url: recipe.smallPhotoURL)

                Text(recipe.name)
                    .font(.subheadline)
                    .frame(width: 150, height: 50)
                    .minimumScaleFactor(0.05)
                    .lineLimit(2)
                    .foregroundStyle(.primary)
            }
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 2)
        )
    }
}
