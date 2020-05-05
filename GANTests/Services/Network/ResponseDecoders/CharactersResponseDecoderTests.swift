//
//  CharactersResponseDecoderTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

class CharactersResponseDecoderTests: XCTestCase {
    
    // MARK: - Properties

    let decoder = CharactersResponseDecoder()
    
    // MARK: - decode
    
    func testDecode_WithWrongType_ThrowsError() {
        
        let incorrectType = ["value"]
    
        guard let data = try? JSONSerialization.data(withJSONObject: incorrectType, options: .prettyPrinted) else {
            XCTFail("data should not be nil")
            return
        }
    
        XCTAssertThrowsError(try decoder.decode(data: data))
    }
    
    func testDecode_WithCharactersArray_ThrowsNoError() {

        guard let data = Data.contentsOfJSONFileName(fileName: "characters", forClass: CharactersResponseDecoderTests.self) else {
            XCTFail("data should not be nil")
            return
        }
    
        XCTAssertNoThrow(try decoder.decode(data: data))
    }
}
