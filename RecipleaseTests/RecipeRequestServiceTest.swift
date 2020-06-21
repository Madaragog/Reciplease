//
//  RecipeRequestService.swift
//  RecipleaseTests
//
//  Created by Cedric on 15/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

@testable import Reciplease
@testable import Alamofire
import XCTest

class RecipeRequestServiceTest: XCTestCase {

    private var recipeRequestTest = RecipeRequestService()

    override func setUp() {
        super.setUp()

        let manager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockURLProtocol.self]
                return configuration
            }()

            return Session(configuration: configuration)
        }()
        recipeRequestTest = RecipeRequestService(manager: manager)
    }

    override func tearDown() {
        super.tearDown()

//        recipeRequestTest = nil
    }

    func testGetRecipesShouldPostFailCallbackIfError() {
//        given
        MockURLProtocol.responseWithFailure()

        let expectation = XCTestExpectation(description: "waiting for nil callback")
//        when
        recipeRequestTest.getRecipes { (recipes) in
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipesShouldPostFailCallbackIfBadResponseStatusCode() {
//        given
        MockURLProtocol.responseWithStatusCode(code: 400)

        let expectation = XCTestExpectation(description: "waiting for nil callback")
//        when
        recipeRequestTest.getRecipes { (recipes) in
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
/*
    func testGetRecipesShouldPostSuccessCallbackIfCorrectResponse() {
//        given
        MockURLProtocol.responseWithStatusCode(code: 200)

        let expectation = XCTestExpectation(description: "waiting for success callback")
//        when
        recipeRequestTest.getRecipes { (recipes) in
            XCTAssertNotNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
 */
}
