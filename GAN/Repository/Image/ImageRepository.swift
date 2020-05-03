//
//  ImageRepository.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

protocol ImageRepository {

    func fetchImage(with imageURLString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

extension Repository {

    func fetchImage(with imageURLString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {

        guard let request = DefaultNetworkImageRequest(urlString: imageURLString) else {
            completion(.failure(RepositoryError.nilRequest))
            return
        }

        network.loadImage(request: request) { result in

            switch result {

            case .failure(let error):

                completion(.failure(error))

            case .success(let image):

                completion(.success(image))
            }
        }
    }
}
