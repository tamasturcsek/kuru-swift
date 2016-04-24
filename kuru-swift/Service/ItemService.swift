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
        self.url = "http://37.230.100.23:8080/rest/bills/\(billId)/items"
        super.fetch(success: {
            response in
            
            var items = [Item]()
            for (_,subJson):(String, JSON) in response {
                let item = Item(id: subJson["id"].intValue, bill: Bill(), article: Article(), amount: subJson["amount"].intValue, createdate: subJson["createDate"].stringValue, outdate: subJson["outDate"].stringValue)
                for(_,billSubJson):(String, JSON) in subJson["bill"] {
                    item.bill = Bill(id: billSubJson["id"].intValue, openDate: billSubJson["openDate"].stringValue, closeDate: billSubJson["closeDate"].stringValue, sum: billSubJson["sum"].intValue, currency: billSubJson["currency"].stringValue, closed: billSubJson["closed"].boolValue)
                }
                for (_,articleSubJson):(String, JSON) in response {
                    item.article = Article(id: articleSubJson["id"].int!, code: articleSubJson["code"].string!, name: articleSubJson["name"].string!, price: articleSubJson["price"].int!, icon: articleSubJson["icon"].string!, unit: articleSubJson["unit"].string!, description: articleSubJson["description"].string, active: articleSubJson["active"].bool!, articleCategory: ArticleCategory())
                    for (_,articleCategorySubJson):(String, JSON) in subJson["articleCategory"] {
                        item.article.articleCategory = ArticleCategory(id: articleCategorySubJson["id"].int!, code: articleCategorySubJson["code"].string!, name: articleCategorySubJson["name"].string!, icon: articleCategorySubJson["icon"].string!)
                    }
                }
                items.append(item)
            }
            onSuccess(response: items)
        })
    }
}

