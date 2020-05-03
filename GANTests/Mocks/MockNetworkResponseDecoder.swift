//
//  MockNetworkResponseDecoder.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
@testable import GAN

struct MockNetworkResponseDecoder: NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable {
        return "a string was decoded"
    }
}

