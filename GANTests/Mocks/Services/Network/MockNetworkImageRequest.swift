//
//  MockNetworkImageRequest.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
@testable import GAN

struct MockNetworkImageRequest: NetworkImageRequest {

    var url: URL = URL(string: "www.something.cool")!

}
