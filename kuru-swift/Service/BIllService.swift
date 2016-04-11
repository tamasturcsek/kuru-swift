//
//  BIllService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 11/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

/*import Foundation
import SwiftRestModel
import SwiftyJSON

class BillService : SwiftRestModel {
    let url = "http://37.230.100.23:8080/rest/bills"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    func findAll(onSuccess: ((response: [Bill]) -> ())){
        super.fetch(success: {
            response in
            
            var bills = [Bill]()
            for (_,subJson):(String, JSON) in response {
                bills.append(Bill(id: subJson["id"].int!, customer: subJson["customer"].customer!, opendate: subJson["opendate"].string!, closedate: subJson["closedate"].string?, sum: subJson["sum"].int!, currency: subJson["currency"].int!))
            }
            onSuccess(response: bills)
            
            
        })
        
    }
}
*/