//
//  MockRepository.swift
//  GANTests
//
//  Created by Harmeet Singh on 04/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
@testable import GAN

class MockRepository: RepositoryType {

    var fetchCharactersForceLoading: Bool = false
    var fetchCharactersError: Error? = MockError.randomError
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        
        guard !fetchCharactersForceLoading else {
            return
        } 
        
        if let fetchCharactersError = fetchCharactersError {
            completion(.failure(fetchCharactersError))
            return
        }
        
        let characterOne = Character(name: "Walter White", 
                                  imageURLString: "", 
                                  occupation: ["Drug King"], 
                                  status: "", 
                                  nickname: "", 
                                  seasonAppearence: [1, 2, 3, 4, 5])
        let characterTwo = Character(name: "Skylar White", 
                                  imageURLString: "", 
                                  occupation: ["Superwomen"], 
                                  status: "", 
                                  nickname: "", 
                                  seasonAppearence: [1])
        
        completion(.success([characterOne, characterTwo]))
    }
        
    func fetchImage(with imageURLString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        completion(.success(UIImage()))
    }
}
