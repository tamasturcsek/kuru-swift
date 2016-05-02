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
                
                let openDate = NSDate(timeIntervalSince1970: Double(subJson["openDate"].stringValue.subString(0,  length: 10))!)
                let closeDateString = subJson["closeDate"].stringValue
                
                let closeDate :NSDate? = !closeDateString.isEmpty ? NSDate(timeIntervalSince1970: Double(closeDateString.subString(0,  length: 10))!) : nil
                
                bill = Bill(id: subJson["id"].intValue, customer: Customer(),openDate: openDate, closeDate: closeDate, sum: subJson["sum"].doubleValue, currency: subJson["currency"].stringValue, closed: subJson["closed"].boolValue)
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
            let openDate = NSDate(timeIntervalSince1970: Double(response["openDate"].stringValue.subString(0,  length: 10))!)
            let closeDateString = response["closeDate"].stringValue
            
            let closeDate :NSDate? = !closeDateString.isEmpty ? NSDate(timeIntervalSince1970: Double(closeDateString.subString(0,  length: 10))!) : nil
            
            let bill = Bill(id: response["id"].intValue, customer: Customer(),openDate: openDate, closeDate: closeDate, sum: response["sum"].doubleValue, currency: response["currency"].stringValue, closed: response["closed"].boolValue)
            let subCustomerJson = response["customer"]
            bill.customer = Customer(id: subCustomerJson["id"].intValue, code: subCustomerJson["code"].stringValue, name: subCustomerJson["name"].stringValue)
            onSuccess(response: bill)
        })
    }

}
