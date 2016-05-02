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
                customers.append(Customer(id: subJson["id"].intValue, code: subJson["code"].stringValue, name: subJson["name"].stringValue))
            }
           onSuccess(response: customers)
            
            
        })
    }
    
    
    func findByCode(code: String, onSuccess: ((response: Customer) -> ()), onFailure: () -> Void){
            super.rootUrl = "http://37.230.100.23:8080/rest/customers/\(code)"
            super.fetch(success: {
                response in
                let customer = Customer(id: response["id"].intValue, code: response["code"].stringValue, name: response["name"].stringValue)
            
                onSuccess(response: customer)
                }, error: {
                    response in
                   onFailure()
            })
        
    }
}
