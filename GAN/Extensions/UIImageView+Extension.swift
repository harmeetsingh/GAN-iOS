//
//  UIImageView+Extension.swift
//  GAN
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

extension ReactiveExtensions where Self.Base : UIImageView {

    public var animatingImage: Bond<UIImage?> {
        return bond { imageView, image in
            imageView.image = image
            imageView.alpha = 0
            UIView.animate(withDuration: 0.25) { 
                imageView.alpha = 1
            }
        }
    }
}
