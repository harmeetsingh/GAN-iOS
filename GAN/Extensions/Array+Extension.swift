//
//  Array+Extension.swift
//  GAN
//
//  Created by Harmeet Singh on 05/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import Foundation

extension Array where Element : StringProtocol {
    
    func commaSeperatedString() -> String {
        
        self.reduce("") { result, string -> String in
            guard string != self.first else {                
                return result + "\(string)"
            }
            return result + ", \(string)"
        }
    }
}

extension Array where Element == Int {
    
    func commaSeperatedString(with string: String) -> String {
        
        self.reduce(string) { result, string -> String in
            guard string != self.first else {                
                return result + "\(string)"
            }
            return result + ", \(string)"
        }
    }
}
