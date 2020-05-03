//
//  CharactersResponseDecoder.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

struct CharactersResponseDecoder: NetworkResponseDecoder {
    
    func decode(data: Data) throws -> Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode([Character].self, from: data)
    }
}
