//
//  Default.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

struct DefaultNetworkImageRequest: NetworkImageRequest {
    
    // MARK: - Properties

    let url: URL

    // MARK: - Init

    init?(urlString: String) {

        guard let url = URL(string: urlString) else {
            return nil
        }

        self.url = url
    }
}
