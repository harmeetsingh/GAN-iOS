//
//  MockCharactersViewModel.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
@testable import GAN
import Bond

class MockCharactersViewModel: CharactersViewModelType, CharactersViewModelOutputs, CharactersViewModelInputs {

    var outputs: CharactersViewModelOutputs { return self }
    var inputs: CharactersViewModelInputs { return self }
    
    var isLoading: Observable<Bool> = Observable(true)

    var errorAlert: Observable<AlertViewModelType?> = Observable(AlertViewModel.genericError())

    var characterCellViewModels: Observable<[CharacterCellViewModelType]> = Observable([
        CharacterCellViewModel(character: Character(name: "", 
                                                    imageURLString: "", 
                                                    occupation: [String](), 
                                                    status: "", 
                                                    nickname: "", 
                                                    seasonAppearence: [Int]()), 
                               repository: MockRepository())])

    var seasonsCellViewModels: Observable<[SeasonsCellViewModelType]> = Observable([SeasonsCellViewModel(season: "Season 1", isSelected: false)])
    
    var filter: Observable<String> = Observable("all seasons")
    
    var resultsCount: Observable<String?> = Observable("100 results")
    
    var loadCalls = 0
    func load() {
        loadCalls += 1
    }
   
    var searchParameters = [String?]()
    func search(_ searchTerm: String?) {
        searchParameters.append(searchTerm)
    }
    
    var filterParameters = [Int]()
    func filter(with index: Int) {
        filterParameters.append(index)
    }

    func select(_ index: Int) {
        
    }
    
    var resetFilterCalls = 0
    func resetFilter() {
        resetFilterCalls += 1
   }    
}
