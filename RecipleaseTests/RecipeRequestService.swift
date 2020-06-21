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
    let recipeRequest
    func testGetRecipesShouldPostFailCallbackIfError() {

    }

    func testStatusCode200ReturnsStatusCode200() {
        // given
        MockURLProtocol.responseWithStatusCode(code: 200)

        let expectation = XCTestExpectation(description: "Performs a request")

        // when
        sut.login(username: "username", password: "password") { (result) in
            XCTAssertEqual(result.response?.statusCode, 200)
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: 3)
    }
}
