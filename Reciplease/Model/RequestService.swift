//
//  RecipesRequest.swift
//  Reciplease
//
//  Created by Cedric on 08/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation
import Alamofire

class RecipeRequestService {
    private let apiId = APIKeyManager().recipeSearchAPIId
    private let apiKey = APIKeyManager().recipeSearchAPIKey
    private var ingredients = ""

    func request() {
        implementIngredientsForRequest()
        AF.request("https://api.edamam.com/search?app_id=\(apiId)&app_key=\(apiKey)&q=\(ingredients)",
            method: .get).response { response in
            debugPrint(response)
        }
    }

    private func implementIngredientsForRequest() {
        for ingredient in IngredientsService.shared.ingredients {
            self.ingredients.append("\(ingredient.name),")
        }
        print(ingredients)
    }
}
