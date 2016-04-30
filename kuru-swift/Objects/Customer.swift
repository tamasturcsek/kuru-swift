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
    
    init() {
        self.id = 0
        self.code = ""
        self.name = ""
    }
    
    init(id: Int, code: String, name: String) {
        self.id = id
        self.code = code
        self.name = name
    }
    
    class func findAll(success: ((response: [Customer]) -> ())) {
        customerService.findAll(success)
    }
    
    class func findByCode(code: String, success: ((response: Customer) -> ())) {
        customerService.findByCode(code, onSuccess:success)
    }
}