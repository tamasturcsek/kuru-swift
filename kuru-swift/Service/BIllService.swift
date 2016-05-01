//
//  BIllService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 11/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import SwiftRestModel
import SwiftyJSON

class BillService : SwiftRestModel {
    var url = "http://37.230.100.23:8080/rest/bills"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    
    func findByCustomerCode(code: String, onSuccess: ((response: [Bill]) -> ())){
        if(code == "") {
            super.rootUrl = "http://37.230.100.23:8080/rest/customers/000000/bills"
        } else {
            super.rootUrl = "http://37.230.100.23:8080/rest/customers/\(code)/bills"
        }
        super.fetch(success: {
            response in
            
            var bills = [Bill]()
            var bill: Bill
            for (_,subJson):(String, JSON) in response {
                bill = Bill(id: subJson["id"].intValue, customer: Customer(),openDate: subJson["openDate"].stringValue, closeDate: subJson["closeDate"].stringValue, sum: subJson["sum"].doubleValue, currency: subJson["currency"].stringValue, closed: subJson["closed"].boolValue)
                    let subCustomerJson = subJson["customer"]
                    bill.customer = Customer(id: subCustomerJson["id"].intValue, code: subCustomerJson["code"].stringValue, name: subCustomerJson["name"].stringValue)
                bills.append(bill)
            }
            onSuccess(response: bills)
            })
    }
    
    func findActiveByCustomerCode(code: String, onSuccess: ((response: Bill) -> ())){
        super.rootUrl = "http://37.230.100.23:8080/rest/customers/\(code)/activebill"
        super.fetch(success: {
            response in
            var bill = Bill(id: response["id"].intValue, customer: Customer(),openDate: response["openDate"].stringValue, closeDate: response["closeDate"].stringValue, sum: response["sum"].doubleValue, currency: response["currency"].stringValue, closed: response["closed"].boolValue)
            let subCustomerJson = response["customer"]
            bill.customer = Customer(id: subCustomerJson["id"].intValue, code: subCustomerJson["code"].stringValue, name: subCustomerJson["name"].stringValue)
            onSuccess(response: bill)
        })
    }

}
