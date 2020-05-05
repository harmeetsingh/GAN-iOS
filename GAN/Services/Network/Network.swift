//
//  Network.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
import UIKit

protocol Network {

    func load(request: NetworkRequest, decoder: NetworkResponseDecoder, completion: @escaping (Result<Decodable, Error>) -> Void)
    func loadImage(request: NetworkImageRequest, completion: @escaping (Result<UIImage, Error>) -> Void) // Debatable! Could return Data instead of UIImage to keep UIKit outside of Network layer.
}
