//
//  CharacterDetailsViewModel.swift
//  GAN
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import Bond

protocol CharacterDetailsViewModelOutputs {
    
    var name: String { get }
    var image: Observable<UIImage?> { get }
    var occupation: String { get }
    var status: String { get }
    var nickname: String { get }
    var seasons: String { get }
}

protocol CharacterDetailsViewModelType {

    var outputs: CharacterDetailsViewModelOutputs { get }
}

class CharacterDetailsViewModel: CharacterDetailsViewModelType, CharacterDetailsViewModelOutputs {

    // MARK: - Properties
    
    var outputs: CharacterDetailsViewModelOutputs { return self }
    
    let name: String
    let image: Observable<UIImage?> = .init(nil)
    let occupation: String
    let status: String
    let nickname: String
    let seasons: String
    
    // MARK: - Init

    init(character: Character, repository: ImageRepository) {

        name = character.name
        occupation = character.occupation.commaSeperatedString() 
        status = character.status
        nickname = character.nickname
        seasons = character.seasonAppearence.commaSeperatedString(with: "Seasons ")
        
        repository.fetchImage(with: character.imageURLString) { [weak self] result in
            guard case .success(let image) = result else { return }
            self?.image.send(image)
        }
    }
}
