//
//  URLResponse+Extension.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

extension URLResponse {

    func isSuccessfull() -> Bool {

        guard let httpURLResponse = self as? HTTPURLResponse else {
            return false
        }

        return 200 ... 299 ~= httpURLResponse.statusCode
    }
}
