//
//  CharacterDetailsViewModelTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN
import Bond

class CharacterDetailsViewModelTests: XCTestCase {

    // MARK: - Properties
    
    private let viewModel = CharacterDetailsViewModel(character: Character(name: "Walter White", 
                                                                          imageURLString: "", 
                                                                          occupation: ["Drug King"], 
                                                                          status: "Living", 
                                                                          nickname: "King", 
                                                                          seasonAppearence: [1, 2, 3, 4, 5]),
                                                      repository: MockRepository())
    
    // MARK: - Tests
    
    func testInit_NameCorrectValue() {

        XCTAssertEqual(viewModel.outputs.name, "Walter White")
    }
    
    func testInit_OccupationCorrectValue() {

        XCTAssertEqual(viewModel.outputs.occupation, "Drug King")
    }
    
    func testInit_StatusCorrectValue() {

        XCTAssertEqual(viewModel.outputs.status, "Living")
    }

    func testInit_NicknameCorrectValue() {

        XCTAssertEqual(viewModel.outputs.nickname, "King")
    }

    func testInit_SeasonsCorrectValue() {

        XCTAssertEqual(viewModel.outputs.seasons, "Seasons 1, 2, 3, 4, 5")
    }
    
    func testInit_ImageNotNil() {
        
        let expectation = self.expectation(description: #function)
        
        _ = viewModel.outputs.image.observeNext { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
