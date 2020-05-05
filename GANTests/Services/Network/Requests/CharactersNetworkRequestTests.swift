//
//  CharactersNetworkRequestTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class CharactersNetworkRequestTests: XCTestCase {

    // MARK: - Properties

    let request = CharactersNetworkRequest()

    // MARK: - Endpointt

    func testRequest_EndpointCorrectValue() {
        XCTAssertEqual(request.endpoint, "/api/characters")
    }
 
    // MARK: - Method

    func testRequest_MethodCorrectValue() {
        XCTAssertEqual(request.method, .get)
    }

    // MARK: - Nil Values

    func testRequest_QueryCorrectValue() {
         XCTAssertNil(request.query)
     }

    func testRequest_HeadersCorrectValue() {
        XCTAssertNil(request.headers)
    }

    func testRequest_ParametersCorrectValue() {
        XCTAssertNil(request.parameters)
    }
}
