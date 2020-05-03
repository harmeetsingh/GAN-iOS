//
//  NetworkImageRequest.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

protocol NetworkImageRequest {

    // MARK: - Properties

    var url: URL { get }

    func urlRequest() -> URLRequest
}

extension NetworkImageRequest {

    func urlRequest() -> URLRequest {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = NetworkRequestMethod.get.rawValue
        return urlRequest
    }
}

