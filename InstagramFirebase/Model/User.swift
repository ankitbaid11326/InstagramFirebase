//
//  User.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 11/02/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit

struct User{
    let uid : String
    let username: String
    let profileImageUrl: String
    
    init(uid : String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}

