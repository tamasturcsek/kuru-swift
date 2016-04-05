//
//  Bill.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

class Bill {
    var id: Int
    var customer: Customer
    var opendate: String
    var closedate: String?
    var sum: Int
    var currency: String
    
    init(id: Int, customer: Customer, opendate: String, closedate: String, sum: Int, currency: String) {
        self.id = id
        self.customer = customer
        self.opendate = opendate
        self.closedate = closedate
        self.sum = sum
        self.currency = currency
    }
}