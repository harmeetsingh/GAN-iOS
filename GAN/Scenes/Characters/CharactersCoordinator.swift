//
//  CharactersCoordinator.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

protocol CharactersCoordinatorType {
    
    func start(on window: UIWindow)
}

class CharactersCoordinator: CharactersCoordinatorType {
    
    // MARK: - Properties

    private let repository: CharactersRepository
    private let imageRepository: ImageRepository
    private let detailsCoordinator: CharacterDetailsCoordinatorType
    
    private var presentingViewController: UIViewController?
    
    // MARK: - Init
    
    init(repository: CharactersRepository, imageRepository: ImageRepository, detailsCoordinator: CharacterDetailsCoordinatorType) {

        self.repository = repository
        self.imageRepository = imageRepository
        self.detailsCoordinator = detailsCoordinator
    }
    
    func start(on window: UIWindow) {
    
        let viewController: CharactersViewController = .fromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewModel = CharactersViewModel(repository: repository, imageRepository: imageRepository, delegate: self)
        viewController.viewModel = viewModel
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        presentingViewController = viewController
    }
}

// MARK: - CharactersViewModelDelegate

extension CharactersCoordinator: CharactersViewModelDelegate {

    func didSelectCharacter(_ character: Character) {
        guard let presentingViewController = presentingViewController else { return }
        detailsCoordinator.start(on: presentingViewController, with: character)
    }
}
