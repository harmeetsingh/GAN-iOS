//
//  AlertActionViewModel.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

protocol AlertActionViewModelType {
    var title: String { get }
    var style: UIAlertAction.Style { get }
    var action: (() -> Void)? { get }
}

struct AlertActionViewModel: AlertActionViewModelType {
    
    // MARK: - Properties
    
    let title: String
    let style: UIAlertAction.Style
    let action: (() -> Void)?
}
