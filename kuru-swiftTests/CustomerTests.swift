//
//  CustomerTests.swift
//  kuru-swift
//
//  Created by Adam Acs on 07/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation

import XCTest
@testable import kuru_swift

class CustomerTests :XCTestCase {
    func testFindAll() {
        var customers = [Customer]()
        let asyncExpectation = expectationWithDescription("longRunningFunction")
        Customer.findAll({ response in
            customers = response
            asyncExpectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(5) { error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            XCTAssertTrue(customers.count > 0)
            
        }
        
    }
}
