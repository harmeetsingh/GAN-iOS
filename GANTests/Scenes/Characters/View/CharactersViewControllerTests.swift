//
//  CharactersViewControllerTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
import Bond
@testable import GAN

class CharactersViewControllerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var viewController: CharactersViewController!
    private let mockViewModel = MockCharactersViewModel()
    
    // MARK: - Lifecyle
    
    override func setUp() {
        super.setUp()

        viewController = .fromStoryboard()
        viewController.viewModel = mockViewModel
        viewController.loadViewIfNeeded()
    }
    
    // MARK: - Outputs
    
    func testLoadingViewIsHidden_CorrectValue() {
        XCTAssertFalse(viewController.loadingView.isHidden)
    }
    
    func testCharactersCollectionViewCellsCount_CorrectValue() {
        
        let characterCellsCount = viewController.charactersCollectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(characterCellsCount, 1)
    }
    
    func testSeasonsCollectionViewCellsCount_CorrectValue() {
        
        let characterCellsCount = viewController.charactersCollectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(characterCellsCount, 1)
    }
    
    func testFilterLabelText_CorrectValue() {
        XCTAssertEqual(viewController.filterLabel.text, "all seasons")
    }

    func testResultsCountLabelText_CorrectValue() {
        XCTAssertEqual(viewController.resultsCountLabel.text, "100 results")
    }    
    
    // MARK: - Inputs
    
    func testViewLoaded_LoadInputCalled() {
        XCTAssertEqual(mockViewModel.loadCalls, 1)
    }
    
    func testSearchBarTextSet_SearchInputCalledCorrectly() {
        mockViewModel.search("Hello")
        XCTAssertEqual(mockViewModel.searchParameters, ["Hello"])
    }
    
    func testFilterSet_FilterInputCalledCorrectly() {
        mockViewModel.filter(with: 2)
        XCTAssertEqual(mockViewModel.filterParameters, [2])
    }
}
