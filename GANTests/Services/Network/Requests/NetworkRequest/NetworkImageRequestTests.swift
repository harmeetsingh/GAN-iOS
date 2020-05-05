//
//  NetworkImageRequestTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class NetworkImageRequestTests: XCTestCase {

    // MARK: - Properties

    let mockRequest = MockNetworkImageRequest()

    // MARK: - urlRequest

    func testURLRequest_URLCorrectValue() {

        XCTAssertEqual(mockRequest.urlRequest().url?.absoluteString, "www.something.cool")
    }

    func testURLRequest_MethodCorrectValue() {

        XCTAssertEqual(mockRequest.urlRequest().httpMethod, "GET")
    }
}
