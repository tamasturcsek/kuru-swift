//
//  ArticleCategory.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

let articleCategoryService = ArticleCategoryService()

class ArticleCategory {
    var id: Int
    var code: String
    var name: String
    var icon: String
    
    init(id: Int, code: String, name: String, icon: String) {
        self.id = id
        self.code = code
        self.name = name
        self.icon = icon
    }
    
    class func findAll(success: ((response: [ArticleCategory]) -> ())) {
        articleCategoryService.findAll(success)
    }
    
    class func findByArticleCategoryId(id: Int, success: ((response: [ArticleCategory]) -> ())) {
        articleCategoryService.findByArticleCategoryId(id, onSuccess:success)
    }
    
}