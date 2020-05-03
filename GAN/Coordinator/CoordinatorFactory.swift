//
//  CoordinatorFactory.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

protocol CoordinatorFactoryType {
    
    func makeCharacters() -> CharactersCoordinatorType
}

class CoordinatorFactory: CoordinatorFactoryType {
    
    // MARK: - Properties
    
    let repository: RepositoryType
    
    // MARK: - Init
    
    init(repository: RepositoryType) {
        self.repository = repository
    }

    func makeCharacters() -> CharactersCoordinatorType {
        return CharactersCoordinator()
    }
}
