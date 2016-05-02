//
//  User.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 05/04/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

let userService = UserService()

class User :JSONAble{
    var id: Int
    var username: String
    var password: String
    
    init() {
        self.id = 0
        self.username = ""
        self.password = ""
    }
    
    init(id: Int, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    class func login(data: Dictionary<String, AnyObject> = [:],success: ((response: Int) -> ())) {
        userService.login(data,onSuccess: success)
    }
    
}