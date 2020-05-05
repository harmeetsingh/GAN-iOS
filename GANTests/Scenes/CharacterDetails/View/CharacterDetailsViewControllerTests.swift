//
//  CharacterDetailsViewControllerTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
import Bond
@testable import GAN

class CharacterDetailsViewControllerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var viewController: CharacterDetailsViewController!
    
    // MARK: - Lifecyle
    
    override func setUp() {
        super.setUp()

        viewController = .fromStoryboard()
        viewController.viewModel = MockCharacterDetailsViewModel()
        viewController.loadViewIfNeeded()
    }
    
    // MARK: - Outputs
    
    func testNameLabel_TextCorrectValue() {
        
        XCTAssertEqual(viewController.nameLabel.text, "Jimmy")
    }
    
    func testOccupationLabel_TextCorrectValue() {
    
        XCTAssertEqual(viewController.occupationLabel.text, "Lawyer")
    }
    
    func testStatusLabel_TextCorrectValue() {
    
        XCTAssertEqual(viewController.statusLabel.text, "Living but still shady")
    }
    
    func testNicknameLabel_TextCorrectValue() {
    
        XCTAssertEqual(viewController.nicknameLabel.text, "Saul")
    }
    
    func testSeasonsLabel_TextCorrectValue() {
    
        XCTAssertEqual(viewController.seasonsLabel.text, "Season 4, 5")
    }
    
    func testImageView_ImageNotNil() {
        
        XCTAssertNotNil(viewController.imageView.image)
    }
}
