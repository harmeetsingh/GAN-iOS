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
    
    func start(on window: UIWindow) {
    
        let viewController: CharactersViewController = .fromStoryboard()
        let viewModel = CharactersViewModel()
        viewController.viewModel = viewModel
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
