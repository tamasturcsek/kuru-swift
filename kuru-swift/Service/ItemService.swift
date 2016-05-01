//
//  ItemService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 21/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import SwiftRestModel
import SwiftyJSON

class ItemService : SwiftRestModel {
    var url = "http://37.230.100.23:8080/rest/items"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    
    func findByBillId(billId: Int, onSuccess: ((response: [Item]) -> ())){
        super.rootUrl = "http://37.230.100.23:8080/rest/bills/\(billId)/items"
        super.fetch(success: {
            response in
            
            var items = [Item]()
            for (_,subJson):(String, JSON) in response {
                var item = Item(bill: Bill(), article: Article(), amount: subJson["amount"].intValue, createdate: subJson["createDate"].stringValue, outdate: subJson["outDate"].stringValue)
                let billSubJson = subJson["bill"]
                    item.bill = Bill(id: billSubJson["id"].intValue, customer: Customer(), openDate: billSubJson["openDate"].stringValue, closeDate: billSubJson["closeDate"].stringValue, sum: billSubJson["sum"].doubleValue, currency: billSubJson["currency"].stringValue, closed: billSubJson["closed"].boolValue)
                    let subCustomerJson = billSubJson["customer"]
                    item.bill.customer = Customer(id: subCustomerJson["id"].intValue, code: subCustomerJson["code"].stringValue, name: subCustomerJson["name"].stringValue)
                let articleSubJson = subJson["article"]
                    item.article = Article(id: articleSubJson["id"].int!, code: articleSubJson["code"].string!, name: articleSubJson["name"].string!, price: articleSubJson["price"].int!, icon: articleSubJson["icon"].string!, unit: articleSubJson["unit"].string!, description: articleSubJson["description"].string, active: articleSubJson["active"].bool!)
                items.append(item)
            }
            onSuccess(response: items)
        })
    }
    
    func save(items: [Item],onSuccess: ((response: Int) -> ())){
        for item: Item in items {
            let jsonString = JSONSerializer.toJson(item)
            //let json = JSON(jsonString)
            let data = convertStringToDictionary(jsonString)
            super.save( data: data!,
                       success: {
                        response in
                        onSuccess(response: super.statuscode)
                        }, error: {
                        response in
                        onSuccess(response: super.statuscode)
                })
            
        }
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
}

