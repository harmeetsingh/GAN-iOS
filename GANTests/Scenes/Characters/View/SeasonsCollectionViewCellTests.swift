//
//  SeasonsCollectionViewCellTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
import Bond
@testable import GAN

class SeasonsCollectionViewCellTests: XCTestCase {
    
    // MARK: - Properties
    
    private var cell: SeasonsCollectionViewCell!
    private var mockViewModel = MockSeasonsCellViewModel()
    
    // MARK: - Lifecyle
    
    override func setUp() {
        super.setUp()

        let viewController: CharactersViewController = .fromStoryboard()
        viewController.viewModel = MockCharactersViewModel()  
        viewController.loadViewIfNeeded()

        cell = viewController.seasonsCollectionView.dequeueCell(of: SeasonsCollectionViewCell.self, for: IndexPath(item: 0, section: 0))
        cell.viewModel = mockViewModel
    }
    
    // MARK: - Outputs
    
    func testCharacterNameLabelText_CorrectValue() {
        XCTAssertEqual(cell.seasonLabel.text, "Season 1")
    }

    func testImageViewImage_NotNil() {
        XCTAssertEqual(cell.seasonLabel.textColor, .blue)
    }
}
