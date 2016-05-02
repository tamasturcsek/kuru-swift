//
//  DateTests.swift
//  kuru-swift
//
//  Created by Adam Acs on 02/05/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import XCTest
@testable import kuru_swift

class DateTests :XCTestCase {
    func testDate() {
        var str = String(NSDate().timeIntervalSince1970).subString(0, length: 10)
        
        print(str)
    }
}