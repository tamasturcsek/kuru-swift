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
    var customer : Customer
    let openDate: String
    let closeDate: String?
    let sum: Double
    let currency: String
    let closed :Bool
    
    init() {
        self.id = 0
        self.customer = Customer()
        self.openDate = ""
        self.closeDate = ""
        self.sum = 0
        self.currency = ""
        self.closed = false
    }
    
    init(id: Int, customer: Customer, openDate: String, closeDate: String, sum: Double, currency: String, closed: Bool) {
        self.id = id
        self.customer = customer
        self.openDate = openDate
        self.closeDate = closeDate == "" ? "" : closeDate[0...9]
        self.sum = sum
        self.currency = currency
        self.closed = closed
    }
    
    class func findByCustomerCode(code: String, success: ((response: [Bill]) -> ())) {
        billService.findByCustomerCode(code, onSuccess:success)
    }
    
    class func findActiveByCustomerCode(code: String, success: ((response: Bill) -> ())) {
        billService.findActiveByCustomerCode(code, onSuccess:success)
    }
    
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}