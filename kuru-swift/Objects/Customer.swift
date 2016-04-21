//
//  Customer.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 05/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

let customerService = CustomerService()

class Customer {
    var id: Int
    var code: String
    var name: String
    var bills: [Bill]
    
    init(id: Int, code: String, name: String, bills: [Bill]) {
        self.id = id
        self.code = code
        self.name = name
        self.bills = bills
    }
    
    class func findAll(success: ((response: [Customer]) -> ())) {
        customerService.findAll(success)
    }
}