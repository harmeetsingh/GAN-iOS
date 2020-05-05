//
//  AlertViewModelType.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

protocol AlertViewModelType {
    var title: String? { get }
    var message: String? { get }
    var actions: [AlertActionViewModelType] { get }
    var style: UIAlertController.Style { get }
}

struct AlertViewModel: AlertViewModelType, Equatable {
    
    // MARK: - Properties

    let title: String?
    let message: String?
    let actions: [AlertActionViewModelType]
    let style: UIAlertController.Style
    
    static func genericError(okAction: (() -> Void)? = nil) -> AlertViewModel {
        let okayAction = AlertActionViewModel(title: "Okay", style: .default, action: okAction)
        return AlertViewModel(title: nil,
                              message: "Something went wrong. Please try again later.", 
                              actions: [okayAction], 
                              style: .alert)
    }
    
    static func messageError(message: String, okAction: (() -> Void)? = nil) -> AlertViewModel {
        let okayAction = AlertActionViewModel(title: "Okay", style: .default, action: okAction)
        return AlertViewModel(title: nil,
                              message: message, 
                              actions: [okayAction], 
                              style: .alert)
    }
    
    static func == (lhs: AlertViewModel, rhs: AlertViewModel) -> Bool {     
        return lhs.title == rhs.title &&
            lhs.message == rhs.message &&
            lhs.style == rhs.style
    }
}

