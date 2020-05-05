//
//  CharacterDetailsViewController.swift
//  GAN
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import ReactiveKit

class CharacterDetailsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var occupationLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var seasonsLabel: UILabel!
    
    var viewModel: CharacterDetailsViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel.outputs)
    }
    
    func bind(_ outputs: CharacterDetailsViewModelOutputs) {

        nameLabel.text = viewModel.outputs.name
        occupationLabel.text = viewModel.outputs.occupation
        statusLabel.text = viewModel.outputs.status
        nicknameLabel.text = viewModel.outputs.nickname
        seasonsLabel.text = viewModel.outputs.seasons

        viewModel.outputs.image
            .bind(to: imageView.reactive.animatingImage)
            .dispose(in: disposeBag)
    }
}
