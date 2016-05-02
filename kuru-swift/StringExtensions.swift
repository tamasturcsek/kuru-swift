//
//  StringExtensions.swift
//  kuru-swift
//
//  Created by Adam Acs on 02/05/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation

extension String {
    func split(separator: Character) -> [String] {
        return self.characters.split(separator).map {String($0)}
    }
    
    /**
     Classic substring with character index.
     */
    func subString(startIndex: Int, length: Int) -> String
    {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        return self.substringWithRange(start..<end)
    }
}