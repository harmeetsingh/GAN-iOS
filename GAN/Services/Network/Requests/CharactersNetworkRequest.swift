//
//  CharactersNetworkRequest.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

struct CharactersNetworkRequest: NetworkRequest {
    
    // MARK: - Properties
    
    let endpoint: String = "/api/characters"
    let query: String? = nil
    let method: NetworkRequestMethod = .get
    let headers: [String : String]? = nil
    let parameters: [String : AnyObject]? = nil
}
