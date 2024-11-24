//
//  RecipeViewModal.swift
//  RecipeTakeHome


import SwiftUI
import UIKit

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var sections: [String] = []
    @Published var allRecipes: Recipes = Recipes(recipes: [])
    @Published var sortedRecipes: [String: [Recipe]] = [:]
    @Published var loading: Bool = true
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    
    init() {
        Task {
            try? await getAllRecipes()
        }
    }
    
    public func getAllRecipes(url: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") async throws {
        guard let recipeURL = URL(string: url) else { return }
        let recipeRequest = URLRequest(url: recipeURL)
        
        let (data, _) = try await URLSession.shared.data(for: recipeRequest)
        do  {
            
            allRecipes = try JSONDecoder().decode(Recipes.self, from: data)
            let cuisineTypes = (allRecipes.recipes.map { $0.cuisineType })
            sections = Array(Set(cuisineTypes)).sorted()
            
            for recipe in allRecipes.recipes {
                if sortedRecipes[recipe.cuisineType] == nil {
                    sortedRecipes[recipe.cuisineType] = [recipe]
                } else {
                    sortedRecipes[recipe.cuisineType]?.append(recipe)
                }
            }
            
            loading = false
            
        } catch {
            loading = false
            showError = true
            errorText = error.localizedDescription
        }
    }
}
