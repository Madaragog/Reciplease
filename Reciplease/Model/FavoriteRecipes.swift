//
//  FavoriteRecipes.swift
//  Reciplease
//
//  Created by Cedric on 28/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation
import CoreData

class FavoriteRecipes {
    static let shared = FavoriteRecipes()
    private init() {}

    func saveFavoriteRecipe(recipe: RecipeAdded) {
        let savedRecipe = SavedRecipe(context: AppDelegate.viewContext)
        savedRecipe.from(recipe: recipe)
        try? AppDelegate.viewContext.save()
    }

    func getFavoriteRecipes() -> [RecipeAdded] {
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        guard let savedRecipes = try? AppDelegate.viewContext.fetch(request) else {
            print("request error")
            return [RecipeAdded]()
        }
        return savedRecipes.map {$0.toRecipeAdded()}
    }

    func deleteFavoriteRecipe(recipe: RecipeAdded) {
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "originalRecipeUrl == %@", recipe.originalRecipeUrl)

        guard let savedRecipes = try? AppDelegate.viewContext.fetch(request), savedRecipes.count > 0 else {
            print("request error")
            return
        }
        AppDelegate.viewContext.delete(savedRecipes[0])
    }
}
