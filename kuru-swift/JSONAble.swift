//
//  JSONAble.swift
//  kuru-swift
//
//  Created by Adam Acs on 02/05/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import Foundation

protocol JSONAble {}

extension JSONAble {
    func toDict() -> [String:AnyObject] {
        var dict = [String:AnyObject]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                if child.value is JSONAble{
                    dict[key] = (child.value as! JSONAble).toDict()
                }
                else if child.value is NSDate {
                    let date =  (child.value as! NSDate)
                    
                    dict[key] = String(date.timeIntervalSince1970).subString(0, length: 10)
                }
                else {
                    dict[key] = child.value as? AnyObject
                }
            }
        }
        return dict
    }
}