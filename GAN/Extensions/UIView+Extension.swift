//
//  UIView+Extension.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

extension ReactiveExtensions where Self.Base : UIView {

    public var isVisible: Bond<Bool> {
        return bond { $0.isHidden = !$1 }
    }
}
