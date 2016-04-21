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
    let url = "http://37.230.100.23:8080/rest/customers"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    func findAll(onSuccess: ((response: [Customer]) -> ())){
        super.fetch(success: {
             response in
         
            var customers = [Customer]()
            for (_,subJson):(String, JSON) in response {
                customers.append(Customer(id: subJson["id"].int!, code: subJson["userId"].string!, name: subJson["title"].string!/*, bills: subJson["bills"].string!*/))
            }
           onSuccess(response: customers)
            
            
        })
        
    }
}
