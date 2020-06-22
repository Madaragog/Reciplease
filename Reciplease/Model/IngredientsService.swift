//
//  IngredientsService.swift
//  Reciplease
//
//  Created by Cedric on 07/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation
import Mockingjay

class IngredientsService {
    static let shared = IngredientsService()
    private init() {}

    private(set) var ingredients: [IngredientAdded] = []

    func add(ingredient: IngredientAdded) {
        ingredients.append(ingredient)
    }

    func removeAll() {
        ingredients.removeAll()
    }
}
