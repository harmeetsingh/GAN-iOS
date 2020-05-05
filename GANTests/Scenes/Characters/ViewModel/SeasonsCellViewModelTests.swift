//
//  SeasonsCellViewModelTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class SeasonsCellViewModelTests: XCTestCase {

    // MARK: - Properties
    
    private let viewModel = SeasonsCellViewModel(season: "season 1", isSelected: false)
    
    // MARK: - Tests
    
    func testInit_NameCorrectValue() {
        
        XCTAssertEqual(viewModel.outputs.season, "season 1")
    }
    
    func testInit_IsSelectedFalse_TextFontCorrectValue() {
        XCTAssertEqual(viewModel.outputs.textFontColor, .black)
    }

    func testInit_IsSelectedTrue_TextFontCorrectValue() {
        let viewModel = SeasonsCellViewModel(season: "season 1", isSelected: true)
        XCTAssertEqual(viewModel.outputs.textFontColor, .white)
    }
}
