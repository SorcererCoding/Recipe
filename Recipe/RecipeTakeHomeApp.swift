//
//  RecipeTakeHomeApp.swift
//  RecipeTakeHome
//

import SwiftUI

@main
struct RecipeTakeHomeApp: App {
    var body: some Scene {
        var viewModel = RecipeViewModel()
        WindowGroup {
            RecipeView(viewModel: viewModel)
        }
    }
}
