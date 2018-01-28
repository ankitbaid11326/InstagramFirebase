//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 28/01/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout =  UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .darkGray
        
        viewControllers = [navController]
        
        
        
        
    }
}
