//
//  RecipeRequestService.swift
//  RecipleaseTests
//
//  Created by Cedric on 15/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

@testable import Reciplease
import Mockingjay
import XCTest

class RecipeRequestServiceTest: XCTestCase {
    let recipeRequestService = RecipeRequestService.shared
/*
    func test() {
        let url = Bundle(for: type(of: self)).url(forResource: "RecipeData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        stub(everything, json(data))
    }
*/
    func testGetRecipesShouldPostFailCallbackIfError() {
//        given
        stub(everything, failure(NSError(domain: "", code: 1, userInfo: nil)))

        let expectation = XCTestExpectation(description: "waiting for nil callback")
//        when
        recipeRequestService.getRecipes { (recipes) in
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
