//
//  CharactersRepository.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

protocol CharactersRepository {
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}

extension Repository {

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        
        let request = CharactersNetworkRequest()
        let responseDecoder = CharactersResponseDecoder()
  
        network.load(request: request, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):
                completion(.failure(error))

            case .success(let decodedData):

                guard let characters = decodedData as? [Character] else {
                    completion(.failure(RepositoryError.unexpectedResponseType))
                    return
                }

                completion(.success(characters))
            }
        }
    }
}
