//
//  Bill.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

class Bill {
    let id: Int
    let openDate: String
    let closeDate: String?
    let sum: Int
    let currency: String
    let closed :Bool
    
    init(id: Int, openDate: String, closeDate: String, sum: Int, currency: String, closed: Bool) {
        self.id = id
        self.openDate = openDate
        self.closeDate = closeDate
        self.sum = sum
        self.currency = currency
        self.closed = closed
    }
}