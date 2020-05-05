//
//  SeasonsCollectionViewCell.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

class SeasonsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    @IBOutlet var seasonLabel: UILabel!

    var viewModel: SeasonsCellViewModelType! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
    }
    
    private func updateUI() {
        seasonLabel.text = viewModel.outputs.season
        seasonLabel.textColor = viewModel.outputs.textFontColor
    }
}
