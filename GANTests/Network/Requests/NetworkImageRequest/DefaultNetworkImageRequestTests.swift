//
//  DefaultNetworkImageRequest.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class DefaultNetworkImageRequestTests: XCTestCase {

    // MARK: - Properties

    let request = DefaultNetworkImageRequest(urlString: "/something.cool.jpg")

    // MARK: - Init

    func testInit_URLCorrectValue()  {

        XCTAssertEqual(request?.url.absoluteURL.absoluteString, "/something.cool.jpg")
    }
}
