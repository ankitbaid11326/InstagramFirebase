//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 28/01/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        let layout =  UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .darkGray
        
        viewControllers = [navController]
        
        
        
        
    }
}
