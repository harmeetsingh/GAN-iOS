//
//  MockNetwork.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
@testable import GAN

class MockNetwork: Network {

    var error: Error?
    var responseObject: Decodable?
    var responseImage: UIImage?

    func load(request: NetworkRequest, decoder: NetworkResponseDecoder, completion: @escaping (Result<Decodable, Error>) -> Void) {

        if let error = error {
            completion(.failure(error))
            return
        }

        if let object = responseObject {
            completion(.success(object))
        }
    }

    func loadImage(request: NetworkImageRequest, completion: @escaping (Result<UIImage, Error>) -> Void) {

        if let error = error {
            completion(.failure(error))
            return
        }

        if let object = responseImage {
            completion(.success(object))
        }
    }

    func reset() {

        error = nil
        responseObject = nil
        responseImage = nil
    }
}
