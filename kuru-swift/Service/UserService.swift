//
//  UserService.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 21/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation
import SwiftRestModel
import SwiftyJSON

class UserService : SwiftRestModel {
    var url = "http://37.230.100.23:8080/rest/users"
    
    init() {
        super.init(rootUrl: self.url)
    }
    
    func login(data: Dictionary<String, AnyObject> = [:],onSuccess: ((response: Int) -> ())){
        super.save(data: data,
            success: {
            response in
            onSuccess(response: super.statuscode)
            }, error: {
                response in
                onSuccess(response: super.statuscode)
        })
        
    }

    
    
    
}