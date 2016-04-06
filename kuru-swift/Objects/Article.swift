//
//  Article.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

class Article {
    var id: Int
    var code: String
    var name: String
    var price: Int
    var icon: String
    var unit: String
    var description: String?
    var active: Bool
    var articleCategory: ArticleCategory
    
    init(id: Int, code: String, name: String, price: Int, icon: String, unit: String, description: String?, active: Bool, articleCategory: ArticleCategory) {
        self.id = id
        self.code = code
        self.name = name
        self.price = price
        self.icon = icon
        self.unit = unit
        self.description = description
        self.active = active
        self.articleCategory = articleCategory
    }
}