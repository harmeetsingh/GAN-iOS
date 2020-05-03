//
//  NetworkSessionError.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

enum NetworkSessionError: Error, Equatable {

    case unsuccessfulRequest(URLResponse?)
    case nilResponseData
}
