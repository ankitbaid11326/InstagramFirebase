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
    let user : User
    let caption: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
    
}
