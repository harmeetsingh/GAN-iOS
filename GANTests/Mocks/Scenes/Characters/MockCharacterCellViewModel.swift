//
//  MockCharacterCellViewModel.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
@testable import GAN
import Bond

class MockCharacterCellViewModel: CharacterCellViewModelType, CharacterCellViewModelOutputs {

    var outputs: CharacterCellViewModelOutputs { return self }
    var name: String = "Walter White"
    var image: Observable<UIImage?> = Observable(UIImage())
}
