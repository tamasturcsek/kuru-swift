//
//  CustomerService.swift
//  kuru-swift
//
//  Created by Adam Acs on 07/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import SwiftRestModel
import SwiftyJSON

class CustomerService : SwiftRestModel {
    var url = "http://37.230.100.23:8080/rest/customers"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    func findAll(onSuccess: ((response: [Customer]) -> ())){
        super.rootUrl = "http://37.230.100.23:8080/rest/customers"
        super.fetch(success: {
             response in
         
            var customers = [Customer]()
            for (_,subJson):(String, JSON) in response {
                let customer = Customer(id: subJson["id"].intValue, code: subJson["code"].stringValue, name: subJson["name"].stringValue, bills: [Bill]())
                for (_,billsSubJson):(String, JSON) in subJson["bills"] {
                    let bill = Bill(id: billsSubJson["id"].intValue, openDate: String(billsSubJson["openDate"].intValue), closeDate: String(billsSubJson["closeDate"].intValue),sum: billsSubJson["sum"].doubleValue, currency: billsSubJson["currency"].stringValue, closed: billsSubJson["closed"].boolValue)
                    customer.bills.append(bill)
                }
                
                customers.append(customer)
            }
           onSuccess(response: customers)
            
            
        })
    }
    
    
    func findByCode(code: String, onSuccess: ((response: Customer) -> ())){
        super.rootUrl = "http://37.230.100.23:8080/rest/customers/" + code
        super.fetch(success: {
            response in
            var customer = Customer()
            for (_,subJson):(String, JSON) in response {
                customer = Customer(id: subJson["id"].intValue, code: subJson["code"].stringValue, name: subJson["name"].stringValue, bills: [Bill]())
                for (_,billsSubJson):(String, JSON) in subJson["bills"] {
                    let bill = Bill(id: billsSubJson["id"].intValue, openDate: String(billsSubJson["openDate"].intValue), closeDate: String(billsSubJson["closeDate"].intValue),sum: billsSubJson["sum"].doubleValue, currency: billsSubJson["currency"].stringValue, closed: billsSubJson["closed"].boolValue)
                    customer.bills.append(bill)
                }
                
            }
            onSuccess(response: customer)
            
            
        })
    }
}
