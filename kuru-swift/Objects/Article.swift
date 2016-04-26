//
//  Article.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

let articleService = ArticleService()

class Article {
    var id: Int
    var code: String
    var name: String
    var price: Int
    var icon: String
    var unit: String
    var description: String?
    var active: Bool
    
    init() {
        self.id = 0
        self.code = ""
        self.name = ""
        self.price = 0
        self.icon = ""
        self.unit = ""
        self.description = ""
        self.active = false
    }
    
    init(id: Int, code: String, name: String, price: Int, icon: String, unit: String, description: String?, active: Bool) {
        self.id = id
        self.code = code
        self.name = name
        self.price = price
        self.icon = icon
        self.unit = unit
        self.description = description
        self.active = active
    }
    
    class func findAll(success: ((response: [Article]) -> ())) {
        articleService.findAll(success)
    }
    
    class func findByArticleCategoryId(id: Int, success: ((response: [Article]) -> ())) {
        articleService.findByArticleCategoryId(id, onSuccess:success)
    }
}