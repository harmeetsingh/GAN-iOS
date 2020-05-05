//
//  CharacterCellViewModelTest.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class CharacterCellViewModelTests: XCTestCase {

    // MARK: - Properties
    
    private var viewModel: CharacterCellViewModel!
    private let mockRepository = MockRepository()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()

        let character = Character(name: "Walter White", 
                                  imageURLString: "", 
                                  occupation: ["Drug King"], 
                                  status: "", 
                                  nickname: "", 
                                  seasonAppearence: [1, 2, 3, 4, 5])
        
        viewModel = CharacterCellViewModel(character: character, repository: mockRepository)
    }
    
    func testInit_NameCorrectValue() {
        XCTAssertEqual(viewModel.outputs.name, "Walter White")
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
