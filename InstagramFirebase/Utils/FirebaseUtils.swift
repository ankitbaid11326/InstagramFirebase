//
//  FirebaseUtils.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 11/02/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit
import Firebase

extension Database{
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()){
        print("Fetching user with uid:", uid)
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictionary: userDictionary)
            
            
            completion(user)
            
        }) { (error) in
            print("Failed to fetch user post for posts", error)
        }
        
    }
}
