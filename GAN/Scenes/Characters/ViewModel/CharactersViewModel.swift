//
//  CharactersViewModel.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

protocol CharactersViewModelDelegate: class {
    
    func didSelectCharacter(_ character: Character)
}

protocol CharactersViewModelOutputs {
    
    var isLoading: Observable<Bool> { get }
    var errorAlert: Observable<AlertViewModelType?> { get }
    var characterCellViewModels: Observable<[CharacterCellViewModelType]> { get }
    var seasonsCellViewModels: Observable<[SeasonsCellViewModelType]> { get }
    var filter: Observable<String> { get }
    var resultsCount: Observable<String?> { get }
}

protocol CharactersViewModelInputs {
    
    func load()
    func search(_ searchTerm: String?)
    func filter(with index: Int)
    func select(_ index: Int)
    func resetFilter()
}

protocol CharactersViewModelType {
    
    var outputs: CharactersViewModelOutputs { get }
    var inputs: CharactersViewModelInputs { get }
}

class CharactersViewModel: CharactersViewModelType, CharactersViewModelOutputs, CharactersViewModelInputs {
    
    // MARK: - Properties
    
    var outputs: CharactersViewModelOutputs { return self }
    var inputs: CharactersViewModelInputs { return self }
    
    let isLoading: Observable<Bool> = .init(true)
    let errorAlert: Observable<AlertViewModelType?> = .init(nil)
    let characterCellViewModels: Observable<[CharacterCellViewModelType]> = .init([CharacterCellViewModelType]())
    let seasonsCellViewModels: Observable<[SeasonsCellViewModelType]> = .init([SeasonsCellViewModelType]())
    let filter: Observable<String> = .init("No filter applied")
    let resultsCount: Observable<String?> = .init(nil)

    private let repository: CharactersRepository
    private let imageRepository: ImageRepository
    private weak var delegate: CharactersViewModelDelegate?
    private var characters = [Character]()
    private var searchTerm: String? = nil
    private var filterIndex: Int? = nil
    
    // MARK: - Init

    init(repository: CharactersRepository, imageRepository: ImageRepository, delegate: CharactersViewModelDelegate?) {
        self.repository = repository
        self.imageRepository = imageRepository
        self.delegate = delegate
    }

    // MARK: - Interaction
    
    func load() {

        isLoading.send(true)

        repository.fetchCharacters { [weak self] result in
            
            guard let self = self else { return }
            self.isLoading.send(false)
            
            switch result {
                
            case .failure(let error):
                let alertViewModel = AlertViewModel.messageError(message: error.localizedDescription)
                self.errorAlert.send(alertViewModel)
            
            case .success(let characters):
                self.characters = characters
                self.updateUI(with: characters, searchTerm: nil, filter: nil)
            }
        }
    }

    func search(_ searchTerm: String?) {
        self.searchTerm = searchTerm
        self.updateUI(with: characters, searchTerm: searchTerm, filter: filterIndex)
    }

    func filter(with index: Int) {
        self.filterIndex = index + 1
        self.updateUI(with: characters, searchTerm: searchTerm, filter: filterIndex)
    }

    func select(_ index: Int) {
        let character = characters[index]
        delegate?.didSelectCharacter(character)
    }
    
    func resetFilter() {
        filterIndex = nil
        self.updateUI(with: characters, searchTerm: searchTerm, filter: filterIndex)
    }
    
    private func updateUI(with characters: [Character], searchTerm: String?, filter: Int?) {
        
        let filteredCharacters = filterCharacters(characters, searchTerm: searchTerm, filter: filter)

        let characterViewModels = filteredCharacters
            .map { CharacterCellViewModel(character: $0, repository: imageRepository) }

        let seasonsViewModels = characters
            .map { $0.seasonAppearence }
            .reduce([Int]()) { result, seasonAppearence -> [Int] in
                guard seasonAppearence.count > result.count else { return result  }
                return seasonAppearence
            }.map { SeasonsCellViewModel(season: "Season \($0)", isSelected: (filter == $0) == true ) }
        
        if let filter = filter {
            self.filter.send("Season \(filter) Filter Set")
        } else {
            self.filter.send("No filter applied")
        }

        let resultsCount = "\(filteredCharacters.count) results"
        
        self.characterCellViewModels.send(characterViewModels)
        self.seasonsCellViewModels.send(seasonsViewModels)
        self.resultsCount.send(resultsCount)
    }
    
    private func filterCharacters(_ characters: [Character], searchTerm: String?, filter: Int?) -> [Character] {

        switch (searchTerm, filter) {

         case (.some(let searchTerm), nil):

             guard !searchTerm.isEmpty else { return characters }
             return characters
                 .filter { $0.name.contains(searchTerm) }
             
         case (nil, .some(let filter)):

            return characters
                 .filter { $0.seasonAppearence.contains(filter) }

         case (.some(let searchTerm), .some(let filter)):

            if searchTerm.isEmpty {
                return characters
                    .filter { $0.seasonAppearence.contains(filter) }
            } else {
                return characters
                    .filter { $0.name.contains(searchTerm) }
                    .filter { $0.seasonAppearence.contains(filter) }
            }

        default:
            return characters
         }
    }
}
