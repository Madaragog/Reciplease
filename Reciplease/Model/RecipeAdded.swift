//
//  RecipesAdded.swift
//  Reciplease
//
//  Created by Cedric on 15/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

struct RecipeAdded {
    var name = ""
    var imageUrl = ""
    var originalRecipeUrl = ""
    var ingredientsDetails: [String] = []
    var numberOfLikes = 0
    var preparationTime: Int = 0
    var imageData: Data
}
