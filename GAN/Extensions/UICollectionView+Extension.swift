//
//  UICollectionView+Extension.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

extension UICollectionView {

    func dequeueCell<T: UICollectionViewCell>(of classType: T.Type, for indexPath: IndexPath) -> T {

        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: type(of: T.self)), for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell of type \(T.self)")
        }
        return cell
    }
}
