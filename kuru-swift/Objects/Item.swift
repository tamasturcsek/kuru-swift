//
//  Item.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 05/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

let itemService = ItemService()

class Item {
    var id: Int
    var bill: Bill
    var article: Article
    var amount: Int
    var createdate: String
    var outdate: String?
    
    init() {
        self.id = 0
        self.bill = Bill()
        self.article = Article()
        self.amount = 0
        self.createdate = ""
        self.outdate = ""
    }
    
    init(id: Int, bill: Bill, article: Article, amount: Int, createdate: String, outdate: String) {
        self.id = id
        self.bill = bill
        self.article = article
        self.amount = amount
        self.createdate = createdate
        self.outdate = outdate
    }
    
    class func findByBillId(id: Int, success: ((response: [Item]) -> ())) {
        itemService.findByBillId(id, onSuccess:success)
    }
    
}

