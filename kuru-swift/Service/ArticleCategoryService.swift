//
//  ArticleCategoryService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 08/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import SwiftRestModel
import SwiftyJSON

class ArticleCategoryService : SwiftRestModel {
    let url = "http://37.230.100.23:8080/rest/articlecategories"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    func findAll(onSuccess: ((response: [ArticleCategory]) -> ())){
        super.fetch(success: {
            response in
            
            var articleCategories = [ArticleCategory]()
            for (_,subJson):(String, JSON) in response {
                articleCategories.append(ArticleCategory(id: subJson["id"].int!, code: subJson["code"].string!, name: subJson["name"].string!, icon: subJson["icon"].string!))
            }
            onSuccess(response: articleCategories)
            
            
        })
        
    }
    
    func findByArticleCategoryId(articleCategoryId: Int, onSuccess: ((response: [ArticleCategory]) -> ())){
        super.fetch(data: ["id" : String(articleCategoryId)] ,success: {
            response in
            
            var articleCategories = [ArticleCategory]()
            for (_,subJson):(String, JSON) in response {
                if(subJson["id"].int == articleCategoryId) {
                articleCategories.append(ArticleCategory(id: subJson["id"].int!, code: subJson["code"].string!, name: subJson["name"].string!, icon: subJson["icon"].string!))
                    }
            }
            onSuccess(response: articleCategories)
            
            
        })
        
    }
    
}