//
//  MockCharactersViewModelDelegate.swift
//  GANTests
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
@testable import GAN

class MockCharactersViewModelDelegate: CharactersViewModelDelegate {
    
    var didSelectCharacterCalls = [Character]()
    func didSelectCharacter(_ character: Character) {
        didSelectCharacterCalls.append(character)
    }
}
