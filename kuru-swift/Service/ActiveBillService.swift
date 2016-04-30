//
//  ActiveBillService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 30/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//


import Foundation
import SwiftRestModel
import SwiftyJSON

class ActiveBillService : SwiftRestModel {
    var url = "http://37.230.100.23:8080/rest/bills"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    
    func findActiveByCustomerCode(code: String, onSuccess: ((response: Bill) -> ())){
        super.rootUrl = "http://37.230.100.23:8080/rest/customers/\(code)/activebill"
        super.fetch(success: {
            response in
            let bill = Bill(id: response["id"].intValue, customer: Customer(),openDate: response["openDate"].stringValue, closeDate: response["closeDate"].stringValue, sum: response["sum"].doubleValue, currency: response["currency"].stringValue, closed: response["closed"].boolValue)
            for (_,subCustomerJson):(String, JSON) in response["customer"] {
                bill.customer = Customer(id: subCustomerJson["id"].intValue, code: subCustomerJson["code"].stringValue, name: subCustomerJson["name"].stringValue)
            }
            onSuccess(response: bill)
        })
    }
    
}
