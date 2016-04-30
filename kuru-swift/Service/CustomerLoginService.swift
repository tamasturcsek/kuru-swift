//
//  CustomerLoginService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 30/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import SwiftRestModel
import SwiftyJSON

class CustomerLoginService : SwiftRestModel {
    var url = "http://37.230.100.23:8080/rest/customers"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
 
    func findByCode(code: String, onSuccess: ((response: Customer) -> ())){
        if(code == "") {
            onSuccess(response: Customer())
        } else {
            super.rootUrl = "http://37.230.100.23:8080/rest/customers/\(code)"
            super.fetch(success: {
                response in
                let customer = Customer(id: response["id"].intValue, code: response["code"].stringValue, name: response["name"].stringValue)
                
                onSuccess(response: customer)
                }, error: {
                    response in
                    onSuccess(response: Customer())
            })
        }
    }
}
