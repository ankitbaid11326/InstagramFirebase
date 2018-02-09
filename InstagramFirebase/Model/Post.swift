//
//  Post.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 09/02/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import Foundation

struct Post{
    
    let imageURL: String
    
    init(dictionary: [String: Any]) {
        self.imageURL = dictionary["imageURL"] as? String ?? ""
    }
    
}
