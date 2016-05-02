//
//  Item.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 05/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

let itemService = ItemService()

import Foundation
class Item :JSONAble{
    var bill: Bill
    var article: Article
    var amount: Int
    var createDate: NSDate
    var outdate: NSDate?
    
    init() {
        self.bill = Bill()
        self.article = Article()
        self.amount = 0
        self.createDate = NSDate()
        self.outdate = nil
    }
    
    init(bill: Bill, article: Article, amount: Int, createdate: NSDate, outdate: NSDate?) {
        self.bill = bill
        self.article = article
        self.amount = amount
        self.createDate = createdate
        self.outdate = outdate
    }
    
    class func findByBillId(id: Int, success: ((response: [Item]) -> ())) {
        itemService.findByBillId(id, onSuccess:success)
    }
    
    class func save(items: [Item],success: ((response: Int) -> ())) {
        itemService.save(items,onSuccess: success)
    }
    
}



