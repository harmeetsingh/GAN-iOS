//
//  Repository.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

protocol RepositoryType: CharactersRepository, ImageRepository { }

class Repository: RepositoryType {
    
    // MARK: - Properties
    
    let network: Network
    
    // MARK: - Init
    
    init(network: Network) {
        self.network = network
    }
}
