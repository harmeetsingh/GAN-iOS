//
//  CharacterDetailsCoordinator.swift
//  GAN
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

protocol CharacterDetailsCoordinatorType {

    func start(on presentingViewController: UIViewController, with character: Character)
}

class CharacterDetailsCoordinator: CharacterDetailsCoordinatorType, Coordinator {
    
    // MARK: - Properties
    
    let repository: ImageRepository
    
    // MARK: - Init
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func start(on presentingViewController: UIViewController, with character: Character) {
        
        let viewController: CharacterDetailsViewController = .fromStoryboard()
        viewController.viewModel = CharacterDetailsViewModel(character: character, repository: repository)
        show(viewController, on: presentingViewController, animated: true)
    }
}
