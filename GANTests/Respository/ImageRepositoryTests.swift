//
//  ImageRepositoryTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class ImageRepositoryTests: XCTestCase {

    // MARK: - Properties

    static let mockNetwork = MockNetwork()
    let repository = Repository(network: mockNetwork)
    let imageURLString = "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"

    // MARK: - Lifecycle

    override func tearDown() {
        ImageRepositoryTests.mockNetwork.reset()
    }

    // MARK: - Fetch image tests

    // TODO: test RepositoryError.nilRequest returned

    func testFetchImage_LoadFailed_ReturnsRandomError() {

        ImageRepositoryTests.mockNetwork.error = MockError.randomError

        repository.fetchImage(with: imageURLString) { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.randomError)
            default:
                XCTFail()
            }
        }
    }

    func testFetchImage_LoadSuccessful_ReturnCorrectObjectType() {

        let mockData = Data.contentsOfImageFileName(fileName: "tick", forClass: ImageRepositoryTests.self)!
        let localImage = UIImage(data: mockData)

        ImageRepositoryTests.mockNetwork.responseImage = localImage

        repository.fetchImage(with: imageURLString) { result in

            switch result {

            case .success(let object):

                XCTAssertEqual(object.pngData(), localImage?.pngData())
            default:
                XCTFail()
            }
        }
    }
}

