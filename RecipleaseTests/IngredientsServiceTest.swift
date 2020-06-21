//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Cedric on 15/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import XCTest
@testable import Reciplease

class IngredientsServiceTest: XCTestCase {
    func testGivenIngredientWhenUsingAddFuncThenItShouldBeAppenedToIngredients() {
//        Given
        let ham = IngredientAdded(name: "Ham")
//        When
        IngredientsService.shared.add(ingredient: ham)
//        Then
        XCTAssertEqual(ham.name, IngredientsService.shared.ingredients[0].name)
    }

    func testGivenIngredientAppenedToIngredientsWhenUsingRemoveAllFuncThenIngredientsShouldBeEmpty() {
//        When
        IngredientsService.shared.removeAll()
//        Then
        XCTAssertEqual(0, IngredientsService.shared.ingredients.count)
    }
}
