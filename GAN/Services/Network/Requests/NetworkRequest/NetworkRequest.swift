//
//  NetworkRequest.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

protocol NetworkRequest {

    // MARK: - Properties

    var endpoint: String { get }
    var query: String? { get }
    var method: NetworkRequestMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: AnyObject]? { get }

    func urlRequest(with domain: String) throws -> URLRequest
}

extension NetworkRequest {

    func urlRequest(with domain: String) throws -> URLRequest {

        var base = domain + endpoint

        if let query = query {
            base += query
        }

        guard let url = URL(string: base) else {
            throw NetworkRequestError.nilURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
        }

        if let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                             options: .prettyPrinted)
        }

        return urlRequest
    }
}
