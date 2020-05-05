//
//  CharactersViewModelTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
import Bond
import ReactiveKit
@testable import GAN

class CharactersViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private var viewModel: CharactersViewModel!
    private let mockRepository = MockRepository()
    private let mockDelegate = MockCharactersViewModelDelegate()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        viewModel = CharactersViewModel(repository: mockRepository, imageRepository: mockRepository, delegate: mockDelegate)
    }
    
    // MARK: - fetchCharacters
    
    func testFetchCharacters_RequestFails_ErrorAlertCorrectValue() {
        
        let expectation = self.expectation(description: #function)
        
        mockRepository.fetchCharactersError = MockError.randomError
        viewModel.load()
        
        _ = viewModel.outputs.errorAlert.observeNext { alert in
            let actualAlert = alert as? AlertViewModel
            let expectedAlert = AlertViewModel.messageError(message: MockError.randomError.localizedDescription)
            XCTAssertEqual(actualAlert, expectedAlert)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }

    func testFetchCharacters_RequestInProgress_IsLoadingTrue() {
        
        let expectation = self.expectation(description: #function)

        mockRepository.fetchCharactersForceLoading = true
        viewModel.load()
        
        _ = viewModel.outputs.isLoading.observeNext { isLoading in 
            XCTAssertEqual(isLoading, true)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchCharacters_RequestSuccessfull_CharacterCellViewModelsCorrectValue() {
        
        let expectation = self.expectation(description: #function)
        
        mockRepository.fetchCharactersError = nil
        viewModel.load()
        
        _ = viewModel.outputs.characterCellViewModels.observeNext { characterCellViewModels in

            let expectedCellViewModels = [Character(name: "Walter White", 
                                                    imageURLString: "", 
                                                    occupation: ["Drug King"], 
                                                    status: "", 
                                                    nickname: "", 
                                                    seasonAppearence: [1, 2, 3, 4, 5]),
                                          Character(name: "Skylar White", 
                                                    imageURLString: "", 
                                                    occupation: ["Superwomen"], 
                                                    status: "", 
                                                    nickname: "", 
                                                    seasonAppearence: [1])]
                .map { CharacterCellViewModel(character: $0, repository: self.mockRepository) }

            let actualCellViewModels = characterCellViewModels as? [CharacterCellViewModel] 
            
            XCTAssertEqual(actualCellViewModels, expectedCellViewModels)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchCharacters_RequestSuccessfull_SeasonsCellViewModelsCorrectValue() {
        
        let expectation = self.expectation(description: #function)

        mockRepository.fetchCharactersError = nil
        setUp()
        viewModel.load()
        
        _ = viewModel.outputs.seasonsCellViewModels.observeNext { seasonsCellViewModels in

            let expectedCellViewModels = [1, 2, 3, 4, 5]
                .map { "Season \($0)" }
                .map { SeasonsCellViewModel(season: $0, isSelected: false) }
            
            let actualCellViewModels = seasonsCellViewModels as? [SeasonsCellViewModel] 
            
            XCTAssertEqual(actualCellViewModels, expectedCellViewModels)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }
    
    // MARK: - Search

    func testSearchSet_ResultsCountCorrectValue() {

        let expectation = self.expectation(description: #function)

        mockRepository.fetchCharactersError = nil
        viewModel.load()
        viewModel.search("Wa")
        
        _ = viewModel.outputs.resultsCount.observeNext { resultsCount in

            XCTAssertEqual(resultsCount, "1 results")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }
    
    func testSearchSet_CharacterCellViewModelsCorrectCount() {

        let expectation = self.expectation(description: #function)

        mockRepository.fetchCharactersError = nil
        viewModel.load()
        viewModel.search("Waz")
        
        _ = viewModel.outputs.characterCellViewModels.observeNext { characterCellViewModels in

            XCTAssertEqual(characterCellViewModels.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Filter
    
    func testFilterSet_FilterCorrectValue() {

        let expectation = self.expectation(description: #function)

        viewModel.filter(with: 1)
        
        _ = viewModel.outputs.filter.observeNext { filter in 
            XCTAssertEqual("Season 2 Filter Set", filter)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFilterSet_CharacterCellViewModelsCorrectValue() {

        let expectation = self.expectation(description: #function)
        
        mockRepository.fetchCharactersError = nil
        viewModel.load()

        viewModel.filter(with: 1)
        
        _ = viewModel.outputs.characterCellViewModels.observeNext { characterCellViewModels in
            XCTAssertEqual(characterCellViewModels.count, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    // MARK: - Search & Filter
    
    func testSearchEmpty_FilterSet_CharacterCellViewModelsCorrectCount() {

        let expectation = self.expectation(description: #function)

        mockRepository.fetchCharactersError = nil
        viewModel.load()
        viewModel.search("")
        viewModel.filter(with: 4)
             
        _ = viewModel.outputs.characterCellViewModels.observeNext { characterCellViewModels in

            XCTAssertEqual(characterCellViewModels.count, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testSearchNotEmpty_FilterSet_CharacterCellViewModelsCorrectCount() {

        let expectation = self.expectation(description: #function)

        mockRepository.fetchCharactersError = nil
        viewModel.load()
        viewModel.search("W")
        viewModel.filter(with: 4)
             
        _ = viewModel.outputs.characterCellViewModels.observeNext { characterCellViewModels in

            XCTAssertEqual(characterCellViewModels.count, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    // MARK: - Select
    
    func testSelect_DelegateCalled() {

        mockRepository.fetchCharactersError = nil

        viewModel.load()
        viewModel.select(0)
        XCTAssertEqual(mockDelegate.didSelectCharacterCalls.count, 1)
    }
    
    // MARK: - resetFilter
    
    func testResetFilter() {
        
        let expectation = self.expectation(description: #function)
        
        mockRepository.fetchCharactersError = nil
        viewModel.load()
        viewModel.filter(with: 1)
        viewModel.resetFilter()
        
        _ = viewModel.outputs.filter.observeNext { filter in
            XCTAssertEqual(filter, "No filter applied")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
