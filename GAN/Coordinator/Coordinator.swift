//
//  Coordinator.swift
//  GAN
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

protocol Coordinator {

    func show(_ viewController: UIViewController, on parentViewController: UIViewController, animated: Bool)
}

extension Coordinator {
    
    func show(_ viewController: UIViewController, on parentViewController: UIViewController, animated: Bool) {

        if let navigationController = parentViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: animated)
        } else {
            parentViewController.show(viewController, sender: self)
        }
    }
}
