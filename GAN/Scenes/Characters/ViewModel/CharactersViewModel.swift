//
//  CharactersViewModel.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

protocol CharactersViewModelOutputs {
    
}

protocol CharactersViewModelInputs {
    
}

protocol CharactersViewModelType {
    
    var outputs: CharactersViewModelOutputs { get }
    var inputs: CharactersViewModelInputs { get }
}

class CharactersViewModel: CharactersViewModelType, CharactersViewModelOutputs, CharactersViewModelInputs {
    
    // MARK: - Properties
    
    var outputs: CharactersViewModelOutputs { return self }
    var inputs: CharactersViewModelInputs { return self }

}
