//
//  Item.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 05/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

class Item {
    var id: Int
    var bill: Bill
    var article: Article
    var amount: Int
    var createdate: String
    var outdate: String?
    
    init(id: Int, bill: Bill, article: Article, amount: Int, createdate: String, outdate: String) {
        self.id = id
        self.bill = bill
        self.article = article
        self.amount = amount
        self.createdate = createdate
        self.outdate = outdate
    }
    
}

