//
//  Bill.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

let billService = BillService()

class Bill {
    let id: Int
    let openDate: String
    let closeDate: String?
    let sum: Double
    let currency: String
    let closed :Bool
    
    init() {
        self.id = 0
        self.openDate = ""
        self.closeDate = ""
        self.sum = 0
        self.currency = ""
        self.closed = false
    }
    
    init(id: Int, openDate: String, closeDate: String, sum: Double, currency: String, closed: Bool) {
        self.id = id
        self.openDate = openDate
        self.closeDate = closeDate
        self.sum = sum
        self.currency = currency
        self.closed = closed
    }
    
    class func findByCustomerCode(code: String, success: ((response: [Bill]) -> ())) {
        billService.findByCustomerCode(code, onSuccess:success)
    }
    
}