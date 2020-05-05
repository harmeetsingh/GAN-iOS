//
//  CharacterCellViewModel.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import Bond

protocol CharacterCellViewModelOutputs {
    
    var name: String { get }
    var image: Observable<UIImage?> { get }
}

protocol CharacterCellViewModelType {
    
    var outputs: CharacterCellViewModelOutputs { get }
}

class CharacterCellViewModel: CharacterCellViewModelType, CharacterCellViewModelOutputs, Equatable {
    
    // MARK: - Properties
    
    var outputs: CharacterCellViewModelOutputs { return self }
    
    let name: String
    let image: Observable<UIImage?> = .init(nil)
    let character: Character
    private let repository: ImageRepository
    
    // MARK: - Init
    
    init(character: Character, repository: ImageRepository) {

        self.character = character
        self.repository = repository

        name = character.name
        
        repository.fetchImage(with: character.imageURLString) { [weak self] result in
            guard case .success(let image) = result else { return }
            self?.image.send(image)
        }
    }
    
    static func == (lhs: CharacterCellViewModel, rhs: CharacterCellViewModel) -> Bool {
        return lhs.character == rhs.character
    }
}

