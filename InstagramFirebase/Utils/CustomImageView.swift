//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 10/02/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView : UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(imageUrl: String){
        
        lastURLUsedToLoadImage = imageUrl
        
        if let cahcedImage = imageCache[imageUrl] {
            self.image = cahcedImage
            return
        }
        
        guard let url = URL(string: imageUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("Failed to fetch post image:", error)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else {return}
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
    
}
