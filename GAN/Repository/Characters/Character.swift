//
//  Character.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

struct Character: Decodable {
    
    // MARK: - Properties
    
    let name: String
    let imageURLString: String
    let occupation: [String]
    let status: String
    let nickname: String
    let seasonAppearence: [Int]
    
    enum CodingKeys: String, CodingKey {
        case name, occupation, status, nickname
        case imageURLString = "img"
        case seasonAppearence = "appearance"
    }
}
