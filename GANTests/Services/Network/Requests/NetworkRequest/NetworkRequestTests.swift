//
//  NetworkRequestTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

/// FYI - Tests in Given, When, Then format
class NetworkRequestTests: XCTestCase {

    // MARK: - Properties

    let validRequest = MockNetworkRequest(endpoint: "/endpoint",
                                          query: "?hello=jjj",
                                          method: .get,
                                          headers: ["Authorization" :  "Bearers npnopn"],
                                          parameters: ["product" :  "super cool" as AnyObject])

    // MARK: - Error scenarios

    func testRequest_EmptyURL_ReturnsCorrectError() {

        let emptyRequest = MockNetworkRequest(endpoint: "",
                                              query: "",
                                              method: .get,
                                              headers: nil,
                                              parameters: nil)

        XCTAssertThrowsError(try emptyRequest.urlRequest(with: "")) { error in

            guard let networkRequestError = error as? NetworkRequestError else {
                XCTFail("error not of type NetworkRequestError")
                return
            }

            XCTAssertEqual(networkRequestError, NetworkRequestError.nilURL)
        }
    }

    // MARK: - Success scenarios

    func testRequest_ValidRequest_ReturnsNoError() {
        XCTAssertNoThrow(try validRequest.urlRequest(with: "www.something.cool"))
    }

    // TODO: Test domain correct value
    // TODO: Test endpoint correct value
    // TODO: Test query correct value
    // TODO: Test method correct value
    // TODO: Test headers correct value
    // TODO: Test parameters correct value
}
