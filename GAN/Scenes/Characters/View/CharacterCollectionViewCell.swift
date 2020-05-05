//
//  CharacterCollectionViewCelll.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class CharacterCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var characterNameLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    var viewModel: CharacterCellViewModelType! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        characterNameLabel.text = nil
    }
    
    private func updateUI() {

        characterNameLabel.text = viewModel.outputs.name

        viewModel.outputs.image
            .bind(to: imageView.reactive.animatingImage)
            .dispose(in: disposeBag)
    }
}
