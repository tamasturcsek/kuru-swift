//
//  ArticleCategory.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

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
}