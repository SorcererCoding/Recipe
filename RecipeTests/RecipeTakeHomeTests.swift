//
//  RecipeTakeHomeTests.swift
//  RecipeTakeHomeTests

import XCTest
@testable import RecipeTakeHome

@MainActor
final class RecipeTakeHomeTests: XCTestCase {

    var recipeViewModel: RecipeViewModel!
    
    override func setUpWithError() throws {
        recipeViewModel = RecipeViewModel()
    }

    override func tearDownWithError() throws {
        recipeViewModel = nil
    }

    func testGetAllRecipes_Success() async throws {
        try await recipeViewModel.getAllRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        
        XCTAssertFalse(recipeViewModel.allRecipes.recipes.isEmpty, "Did not get back data")
        XCTAssertFalse(recipeViewModel.loading)
    }
    
    func testGetAllRecipes_Empty() async throws {
        try await recipeViewModel.getAllRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        
        XCTAssertTrue(recipeViewModel.allRecipes.recipes.isEmpty, "Data when there shouldn't be")
        XCTAssertFalse(recipeViewModel.loading)
    }
    
    func testGetAllRecipes_InvalidData() async throws {
        try await recipeViewModel.getAllRecipes(url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        
        XCTAssertFalse(recipeViewModel.loading)
        XCTAssertTrue(recipeViewModel.showError)
        XCTAssertEqual(recipeViewModel.errorText, "The data couldn’t be read because it is missing.")
    }
}
