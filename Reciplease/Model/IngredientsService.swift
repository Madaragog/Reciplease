//
//  IngredientsService.swift
//  Reciplease
//
//  Created by Cedric on 07/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class IngredientsService {
    static let shared = IngredientsService()
    private init() {}

    private(set) var ingredients: [IngredientAdded] = []
// Adds an ingredient to ingredients array
    func add(ingredient: IngredientAdded) {
        ingredients.append(ingredient)
    }
// Removes all ingredients from ingredients array
    func removeAll() {
        ingredients.removeAll()
    }
}
