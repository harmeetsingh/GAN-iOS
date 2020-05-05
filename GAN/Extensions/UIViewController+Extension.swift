//
//  File.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

extension UIViewController {

    static func fromStoryboard<T: UIViewController>() -> T {

        let bundle = Bundle(for: self)
        let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            let error = """
            Storyboard for \(self) cant be instantiated.
            Make sure to set an initial Storyboard and the correct custom class.
            """
            fatalError(error)
        }
        return viewController
    }
    
    func present(viewModel: AlertViewModelType?) {
        guard let viewModel = viewModel else { return }

         let alert = UIAlertController(title: viewModel.title,
                                       message: viewModel.message,
                                       preferredStyle: viewModel.style)

         viewModel
             .actions
             .map { action in
                 UIAlertAction(title: action.title, style: action.style) { _ in
                     action.action?()
                 }
             }
             .forEach(alert.addAction)

         present(alert, animated: true, completion: nil)
     }
}

extension ReactiveExtensions where Self.Base : UIViewController {

    var alertViewModel: Bond<AlertViewModelType?> {

        return bond { viewController, alertViewModel in
            viewController.present(viewModel: alertViewModel)
        }
    }
}
