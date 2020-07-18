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
    static let shared = RecipeRequestService()
    private init() {}

    var sharedRecipeList: [RecipeAdded] = []

    private let apiId = APIKeyManager().recipeSearchAPIId
    private let apiKey = APIKeyManager().recipeSearchAPIKey
// gets All the recipes related with the ingredients added to the request
    func getRecipes(callback: @escaping ([RecipeAdded]?) -> Void) {
        AF.cancelAllRequests()
        sharedRecipeList = []
        let ingredient = ingredientsStringCreation()
        AF.request("https://api.edamam.com/search?app_id=\(apiId)&app_key=\(apiKey)&q=\(ingredient)",
            method: .get).responseJSON { response in
                guard let data = response.data, response.error == nil else {
                    callback(nil)
                    return
                }
                guard let response = response.response, response.statusCode == 200 else {
                    callback(nil)
                    return
                }
                guard let recipesResponse = try? JSONDecoder().decode(ReceipesResponse.self, from: data) else {
                    callback(nil)
                    return
                }
                for recipes in recipesResponse.hits {
                    self.sharedRecipeList.append(RecipeAdded(name: recipes.recipe.label,
                                                       imageUrl: recipes.recipe.image,
                                                  originalRecipeUrl: recipes.recipe.url,
                                                  ingredientsDetails: recipes.recipe.ingredientLines,
                                                  numberOfLikes: Int(arc4random_uniform(500)),
                                                  preparationTime: Int(arc4random_uniform(40))))
                }
                if self.sharedRecipeList.isEmpty {
                    callback(nil)
                } else {
                    callback(self.sharedRecipeList)
                }
        }
    }
// gets the image of a recipe
    func getImage(imageUrl: String, callback: @escaping (Data?) -> Void) {
       AF.request(imageUrl).responseData { (response) in
            guard let data = response.data, response.error == nil else {
                callback(nil)
                return
            }
            guard let response = response.response, response.statusCode == 200 else {
                callback(nil)
                return
            }
            callback(data)
        }
    }
// creates the correct string of ingredients for the request of getRecipes
    private func ingredientsStringCreation() -> String {
        var ingredients = ""
        for ingredient in IngredientsService.shared.ingredients {
            ingredients.append("\(ingredient.name.filter({!" ".contains($0) })),")
        }
        if ingredients != "" {
            ingredients.removeLast()
        }
        return ingredients
    }

}
// swiftlint:disable identifier_name redundant_string_enum_value
// MARK: - ReceipesResponse
struct ReceipesResponse: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let bookmarked, bought: Bool
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels: [String]
    let healthLabels: [HealthLabel]
    let cautions: [Caution]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
}

enum Caution: String, Codable {
    case fodmap = "FODMAP"
    case sulfites = "Sulfites"
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

enum HealthLabel: String, Codable {
    case alcoholFree = "Alcohol-Free"
    case peanutFree = "Peanut-Free"
    case sugarConscious = "Sugar-Conscious"
    case treeNutFree = "Tree-Nut-Free"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double
}

// MARK: - Total
struct Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}
