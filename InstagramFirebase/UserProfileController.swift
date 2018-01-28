//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 28/01/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        navigationItem.title = "\(Auth.auth().currentUser?.uid ?? "")"
        fetchUser()
    }
    
    fileprivate func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Inside UserProfileController cannot get userID")
            return
        }
        
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
        
            guard let dictionary = snapshot.value as? [String: Any] else{
                print("UserProfileController fetchUser() cannot unwrap dictionary value")
                return
            }
            let username = dictionary["username"] as? String
            self.navigationItem.title = username
        
        }) { (error) in
            print("Failed to Fetch User", error)
        }
    }

}
