//
//  RecipeView.swift
//  RecipeTakeHome


import SwiftUI

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    var body: some View {
        if viewModel.loading {
            ProgressView()
        } else {
            if viewModel.sortedRecipes.isEmpty {
                Text("No Recipes Available")
                    .font(.largeTitle)
            } else {
                ScrollView{
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 4) {
                        ForEach(Array(viewModel.sortedRecipes.keys).sorted(by: <), id: \.self) { key in
                            Section(header: Text(key).font(.title)) {
                                ForEach(viewModel.sortedRecipes[key] ?? []) { recipe in
                                    RecipeCard(recipe: recipe)
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    try? await viewModel.getAllRecipes()
                }
                .sheet(isPresented: $viewModel.showError) {
                    Text(viewModel.errorText)
                }
            }

        }
    }
}
