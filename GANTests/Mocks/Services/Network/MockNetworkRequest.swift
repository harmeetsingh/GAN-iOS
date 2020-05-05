//
//  MockNetworkRequest.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
@testable import GAN

struct MockNetworkRequest: NetworkRequest {

    let endpoint: String
    let query: String?
    let method: NetworkRequestMethod
    let headers: [String : String]?
    let parameters: [String : AnyObject]?
}

