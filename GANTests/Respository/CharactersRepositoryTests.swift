//
//  CharactersRepositoryTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class CharactersRepositoryTests: XCTestCase {

    // MARK: - Properties

    static let mockNetwork = MockNetwork()
    let repository = Repository(network: mockNetwork)

    // MARK: - Lifecycle

    override func tearDown() {
        CharactersRepositoryTests.mockNetwork.reset()
    }

    // MARK: - fetchClothingItems tests

    func testFetchClothingItems_LoadFailed_ReturnsRandomError() {

        CharactersRepositoryTests.mockNetwork.error = MockError.randomError

        repository.fetchCharacters { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.randomError)
            default:
                XCTFail("")
            }
        }
    }

    func testFetchClothingItems_LoadSuccessful_ReturnsUnexpectedResponseTypeError() {

        CharactersRepositoryTests.mockNetwork.responseObject = ""

        repository.fetchCharacters { result in

            switch result {

            case .failure(let error):

                let repositoryError = error as? RepositoryError
                XCTAssertEqual(repositoryError, RepositoryError.unexpectedResponseType)
            default:
                XCTFail("")
            }
        }
    }

    func testFetchClothingItems_LoadSuccessful_ReturnCorrectObjectType() {
        
        let jsonData = Data.contentsOfJSONFileName(fileName: "characters", forClass: CharactersRepositoryTests.self)

        guard let data = jsonData else {
            XCTFail("data should not be nil")
            return
        }

        let decoder = JSONDecoder()
        CharactersRepositoryTests.mockNetwork.responseObject = try? decoder.decode([Character].self, from: data)

        repository.fetchCharacters { result in

            switch result {

            case .success(let characters):
                XCTAssertEqual(characters.count, 1)
            default:
                XCTFail("")
            }
        }
    }
}
