//
//  NetworkImageResponseDecoder.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation
import UIKit

struct NetworkImageResponseDecoder {

    func decode(data: Data) throws -> UIImage {

        guard let image =  UIImage(data: data) else {
            throw NetworkImageResponseDecoderError.nilImage
        }

        return image
    }
}
