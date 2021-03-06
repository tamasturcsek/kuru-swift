//
//  ArticleService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 08/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import SwiftRestModel
import SwiftyJSON

class ArticleService : SwiftRestModel {
    var url = "http://37.230.100.23:8080/rest/articles"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    func findAll(onSuccess: ((response: [Article]) -> ())){
        super.rootUrl = "http://37.230.100.23:8080/rest/articles"
        super.fetch(success: {
            response in
            
            var articles = [Article]()
            for (_,subJson):(String, JSON) in response {
                articles.append(Article(id: subJson["id"].int!, code: subJson["code"].string!, name: subJson["name"].string!, price: subJson["price"].int!, icon: subJson["icon"].string!, unit: subJson["unit"].string!, description: subJson["description"].string, active: subJson["active"].bool!))
                
            }
            onSuccess(response: articles)
            
            
        })
    }
    
    func findByArticleCategoryId(id: Int, onSuccess: ((response: [Article]) -> ())){
        super.rootUrl = "http://37.230.100.23:8080/rest/articlecategories/\(id)/articles"
        fetch()
        super.fetch(success: {
            response in
            
            var articles = [Article]()
            for (_,subJson):(String, JSON) in response {
                articles.append(Article(id: subJson["id"].int!, code: subJson["code"].string!, name: subJson["name"].string!, price: subJson["price"].int!, icon: subJson["icon"].string!, unit: subJson["unit"].string!, description: subJson["description"].string, active: subJson["active"].bool!))
                
            }
            onSuccess(response: articles)
            
            
        })
    }
}
