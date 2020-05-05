//
//  CharacterCollectionViewCellTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
import Bond
@testable import GAN

class CharacterCollectionViewCellTests: XCTestCase {
    
    // MARK: - Properties
    
    private var cell: CharacterCollectionViewCell!
    private var mockViewModel = MockCharacterCellViewModel()
    
    // MARK: - Lifecyle
    
    override func setUp() {
        super.setUp()

        let viewController: CharactersViewController = .fromStoryboard()
        viewController.viewModel = MockCharactersViewModel()  
        viewController.loadViewIfNeeded()

        cell = viewController.charactersCollectionView.dequeueCell(of: CharacterCollectionViewCell.self, for: IndexPath(item: 0, section: 0))
        cell.viewModel = mockViewModel
    }
    
    // MARK: - Outputs
    
    func testCharacterNameLabelText_CorrectValue() {
        XCTAssertEqual(cell.characterNameLabel.text, "Walter White")
    }

    func testImageViewImage_NotNil() {
        XCTAssertNotNil(cell.imageView.image)
    }
}
