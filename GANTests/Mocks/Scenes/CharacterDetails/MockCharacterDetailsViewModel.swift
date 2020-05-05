//
//  MockCharacterDetailsViewModel.swift
//  GANTests
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
@testable import GAN 
import Bond

class MockCharacterDetailsViewModel: CharacterDetailsViewModelType, CharacterDetailsViewModelOutputs {

    var name: String = "Jimmy"
    var image: Observable<UIImage?> = .init(UIImage())    
    var occupation: String = "Lawyer"
    var status: String = "Living but still shady"
    var nickname: String = "Saul"
    var seasons: String = "Season 4, 5"
    
    var outputs: CharacterDetailsViewModelOutputs { return self }
}
