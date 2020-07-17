//
//  FavoriteRecipesTest.swift
//  RecipleaseTests
//
//  Created by Cedric on 17/07/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import XCTest
@testable import Reciplease

class FavoriteRecipesTest: XCTestCase {
    let favoriteRecipes = FavoriteRecipes.shared
    let recipe = RecipeAdded(name: "recipe",
    imageUrl: "imageUrl",
    originalRecipeUrl: "recipeUrl",
    ingredientsDetails: ["egg", "bread"],
    numberOfLikes: 20,
    preparationTime: 5)

    func testSaveFavoriteRecipeShouldSaveTheRecipeAndTheLatterShouldBeReturnedByGetFavoriteRecipesWhenCalled() {
//        when
        favoriteRecipes.saveFavoriteRecipe(recipe: recipe)
//        Then
        XCTAssertTrue(favoriteRecipes.getFavoriteRecipes().contains(recipe))
        resetDataBaseForTest(recipeToDelete: recipe)
    }

    func testGetFavoriteRecipesShouldReturnEmptyRecipeAddedArrayWhenFetchRequestFails() {
//        Given
        let emptyRecipeAddedArray = [RecipeAdded]()
//        Then
        XCTAssertEqual(favoriteRecipes.getFavoriteRecipes(), emptyRecipeAddedArray)
    }

    func testDeleteFavoriteRecipeShouldDeleteRecipe() {
//        given
        favoriteRecipes.saveFavoriteRecipe(recipe: recipe)
//        when
        favoriteRecipes.deleteFavoriteRecipe(recipe: recipe)
//        Then
        XCTAssertFalse(favoriteRecipes.getFavoriteRecipes().contains(recipe))
    }

    private func resetDataBaseForTest(recipeToDelete: RecipeAdded) {
        favoriteRecipes.deleteFavoriteRecipe(recipe: recipeToDelete)
    }
}
