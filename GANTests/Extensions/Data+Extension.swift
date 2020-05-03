//
//  Data+Extension.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

extension Data {

    static func contentsOfJSONFileName(fileName: String, forClass testClass: AnyClass) -> Data? {

        return Data.contentsOf(fileName: fileName, extention: "json", forClass: testClass)
    }

    static func contentsOfImageFileName(fileName: String, forClass testClass: AnyClass) -> Data? {

        return Data.contentsOf(fileName: fileName, extention: "jpg", forClass: testClass)
    }

    private static func contentsOf(fileName: String, extention: String, forClass testClass: AnyClass) -> Data? {

        let testBundle = Bundle(for: testClass)
        let fileURL = testBundle.url(forResource: fileName, withExtension: extention)

        guard let url = fileURL else {
            return nil
        }

        return try? Data(contentsOf: url)
    }
}
