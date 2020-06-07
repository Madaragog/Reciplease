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

    private(set) var ingredients: [Ingredient] = []

    func add(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }

    func removeAll() {
        ingredients.removeAll()
    }
}
