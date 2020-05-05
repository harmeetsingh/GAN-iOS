//
//  SeasonsCellViewModel.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

protocol SeasonsCellViewModelOutputs {

    var season: String { get }
    var textFontColor: UIColor { get }
}

protocol SeasonsCellViewModelType {
    
    var outputs: SeasonsCellViewModelOutputs { get }
}

struct SeasonsCellViewModel: SeasonsCellViewModelType, SeasonsCellViewModelOutputs, Equatable {
    
    // MARK: - Properties
    
    var outputs: SeasonsCellViewModelOutputs { return self }
    
    let season: String
    let textFontColor: UIColor
    
    // MARK: - Init

    init(season: String, isSelected: Bool) {
        self.season = season
        textFontColor = isSelected ? .white : .black
    }
}
