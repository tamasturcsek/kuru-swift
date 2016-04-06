//
//  ValueSet.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 05/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

class ValueSet {
    var id: Int
    var name: String
    var valuesString: String
    
    init(id: Int, name: String, valuesString: String) {
        self.id = id
        self.name = name
        self.valuesString = valuesString
    }
}