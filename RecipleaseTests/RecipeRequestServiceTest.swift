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
    var correctData: Data {
        let url = Bundle(for: type(of: self)).url(forResource: "RecipeData", withExtension: "json")!
        let data = try? Data(contentsOf: url)
        return data!
    }
    var incorrectJson: Data {
        let url = Bundle(for: type(of: self)).url(forResource: "IncorrectJSON", withExtension: "json")!
        let data = try? Data(contentsOf: url)
        return data!
    }

    func testGetRecipesShouldPostFailCallbackIfError() {
//        given
        stub(everything, failure(NSError(domain: "", code: 1, userInfo: nil)))

        let expectation = XCTestExpectation(description: "waiting for nil callback")
//        when
        recipeRequestService.getRecipes { (recipes) in
//        then
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipesShouldPostFailCallbackIfNoData() {
//        Given
        let incorrectData = "erreur".data(using: .utf8)!
        stub(everything, jsonData(incorrectData))
//        When
        let expectation = XCTestExpectation(description: "waiting for nil callback")
        recipeRequestService.getRecipes { (recipes) in
//        Then
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipesShouldPostFailCallbackIfIncorrectResponse() {
//        Given
        stub(everything, http(500))
//        When
        let expectation = XCTestExpectation(description: "Wait for incorrect response")
        recipeRequestService.getRecipes { (recipes) in
//        Then
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        Given
        stub(everything, jsonData(correctData))
//        When
        let expectation = XCTestExpectation(description: "Wait success callback")
        recipeRequestService.getRecipes { (recipes) in
//        Then
            XCTAssertNotNil(recipes)
            XCTAssertFalse(recipes!.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipesShouldPostFailCallbackIfIncorrectStatusCodeAndCorrectData() {
//        Given
        stub(everything, jsonData(correctData, status: 500, headers: nil))
//        When
        let expectation = XCTestExpectation(description: "Wait fail callback")
        recipeRequestService.getRecipes { (recipes) in
//        Then
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipeShouldPostFailCallbackIfWrongData() {
//        given
        stub(everything, jsonData(incorrectJson, status: 200, headers: nil))
//        When
        let expectation = XCTestExpectation(description: "Wait fail callback")
        recipeRequestService.getRecipes { (recipes) in
//        Then
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetImageShouldPostFailCallbackIfError() {
//        when
        let expectation = XCTestExpectation(description: "waiting for nil callback")
        recipeRequestService.getImage(imageUrl: "") { (image) in
//        Then
            XCTAssertNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetImageShouldPostFailCallbackIfIncorrectStatusCodeAndCorrectData() {
//        Given
        stub(everything, jsonData((UIImage(named: "DefaultRecipeImage")?.pngData())!, status: 404, headers: nil))
//        When
        let expectation = XCTestExpectation(description: "Wait fail callback")
        recipeRequestService.getImage(imageUrl: "") { (image) in
//        then
            XCTAssertNil(image)
            expectation.fulfill()
        }
    }
}
