//
//  SavedRecipe.swift
//  Reciplease
//
//  Created by Cedric on 03/07/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation
import CoreData

class SavedRecipe: NSManagedObject {
    let separator = "#"
    var ingredientsToStringArray = [""]
// converts recipe of type SavedRecipe to RecipeAdded type
    func toRecipeAdded() -> RecipeAdded {
        let ingredientsDetailsSplited = self.ingredientsDetails?.split(separator: "#").map(String.init)

        guard let name = self.name, let imageUrl = self.imageUrl, let originalRecipeUrl = self.originalRecipeUrl,
            let ingredientsToStringArray = ingredientsDetailsSplited else {
            return RecipeAdded()
        }
        return RecipeAdded(name: name, imageUrl: imageUrl, originalRecipeUrl: originalRecipeUrl,
                           ingredientsDetails: ingredientsToStringArray, numberOfLikes: Int(numberOfLikes),
                           preparationTime: Int(preparationTime))
    }
// converts recipe of type RecipeAdded to SavedRecipe type
    func from(recipe: RecipeAdded) {
        self.imageUrl = recipe.imageUrl
        self.ingredientsDetails = recipe.ingredientsDetails.joined(separator: separator)
        self.name = recipe.name
        self.numberOfLikes = Int32(recipe.numberOfLikes)
        self.originalRecipeUrl = recipe.originalRecipeUrl
        self.preparationTime = Int32(recipe.preparationTime)
    }
}
