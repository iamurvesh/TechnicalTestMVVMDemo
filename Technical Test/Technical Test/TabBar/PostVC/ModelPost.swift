//
//  ModelPost.swift
//  Technical Test
//
//  Created by Urvesh on 13/05/22.
//

import Foundation

class ModelPost {
    
    var body : String
    var id : Int
    var title : String
    var userId : Int
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        body = dictionary["body"] as? String ?? ""
        id = dictionary["id"] as? Int ?? Int()
        title = dictionary["title"] as? String ?? ""
        userId = dictionary["userId"] as? Int ?? Int()
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["body"] = body
        dictionary["id"] = id
        dictionary["title"] = title
        dictionary["userId"] = userId
        return dictionary
    }
}
