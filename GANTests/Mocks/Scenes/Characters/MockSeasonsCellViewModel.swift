//
//  MockSeasonsCellViewModel.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
@testable import GAN
import Bond

struct MockSeasonsCellViewModel: SeasonsCellViewModelType, SeasonsCellViewModelOutputs {

    var outputs: SeasonsCellViewModelOutputs { return self }
    var season: String = "Season 1"
    var textFontColor: UIColor = .blue
}
