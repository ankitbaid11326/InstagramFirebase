//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 29/01/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBotton: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius =  80 / 2
        profileImageView.clipsToBounds =  true
        
    }
    
    var user: User?{
        didSet{
            setupProfileImage()
        }
    }
    
    fileprivate func setupProfileImage(){
        
        guard let profileImageUrl = user?.profileImageUrl else {
            print("UserProfileHeader->user->didSet->profileImageUrl failed to extract user profile Image")
            return
        }
        
        guard let url = URL(string: profileImageUrl) else {
            print("UserProfileHeader->user->didSet->url failed to get URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("UserProfileHeader->user->didSet->URLSession->error Failed to fetch Profile Image", error)
                return
            }
            
            print(data)
            
            guard let data = data else {
                print("UserProfileHeader->user->didSet->URLSERSSION->data Failed to get data from URLSession")
                return
            }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            }.resume()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
