//
//  NetworkSession.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
import UIKit

class NetworkSession: Network {

    // MARK: - Properties

    let session: URLSession
    let domain: String

    // MARK: - Init

    init(session: URLSession, domain: String) {

        self.session = session
        self.domain = domain
    }

    // MARK: - Load

    func load(request: NetworkRequest, decoder: NetworkResponseDecoder, completion: @escaping (Result<Decodable, Error>) -> Void) {

        do {

            let urlRequest = try request.urlRequest(with: domain)

            perform(request: urlRequest) { result in

                switch result {

                case .failure(let error):

                    completion(.failure(error))

                case .success(let data):

                    NetworkSession.decode(data: data, with: decoder, completion: completion)
                }
            }

        } catch let requestError {

            completion(.failure(requestError))
        }
    }

    func loadImage(request: NetworkImageRequest, completion: @escaping (Result<UIImage, Error>) -> Void) {

        let urlRequest = request.urlRequest()
        let decoder = NetworkImageResponseDecoder()

        perform(request: urlRequest) { result in

            switch result {

            case .failure(let error):

                completion(.failure(error))

            case .success(let data):

                do {

                    let image = try decoder.decode(data: data)
                    completion(.success(image))

                } catch let error {

                    completion(.failure(error))
                }
            }
        }
    }

    private func perform(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {

        session.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard response?.isSuccessfull() == true else {
                    completion(.failure(NetworkSessionError.unsuccessfulRequest(response)))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkSessionError.nilResponseData))
                    return
                }

                completion(.success(data))
            }
        }.resume()
    }

    private static func decode(data: Data, with decoder: NetworkResponseDecoder, completion: (Result<Decodable, Error>) -> Void) {

        do {

            let decodeable = try decoder.decode(data: data)
            completion(.success(decodeable))

        } catch let error {

            completion(.failure(error))
        }
    }
}
