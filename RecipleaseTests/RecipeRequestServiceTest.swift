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
/*
class RecipeRequestServiceTest: XCTestCase {
    let recipeRequestService = RecipeRequestService()
    let matcher = uri("https://openclassrooms.com/")
    override func setUp() {
      super.setUp()
      let url = Bundle(for: type(of: self)).url(forResource: "RecipeData", withExtension: "json")!
      let data = try! Data(contentsOf: url)
        stub(matcher, jsonData(data))
    }

    class ConverterError: NSError {}
    let error = ConverterError()

    func builder(request: URLRequest) -> Response {
        return .failure(error)
    }

    func testGetRecipesShouldPostFailCallbackIfError() {
//        given
        stub(matcher, builder(request:))

        let expectation = XCTestExpectation(description: "waiting for nil callback")
//        when
        recipeRequestService.getRecipes { (recipes) in
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
*/
