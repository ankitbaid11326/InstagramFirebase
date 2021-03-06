//
//  SharePhotoController.swift
//  InstagramFirebase
//
//  Created by Ankit Baid on 31/01/18.
//  Copyright © 2018 Ankit Baid. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet{
            self.imageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
        
    }
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    fileprivate func setupImageAndTextViews(){
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBotton: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBotton: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBotton: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    @objc func handleShare(){
        
        guard let image = selectedImage else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return  }
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(filename).putData(uploadData, metadata: nil) { (metadata, error) in
            if let error = error{
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload the image:", error)
                return
            }
            
            guard let imageURL = metadata?.downloadURL()?.absoluteString else { return }
            
            print("Successfully uploaded image", imageURL)
            
            self.saveToDatabaseWithImageURL(imageURL: imageURL)
        }
    }
    
    fileprivate func saveToDatabaseWithImageURL(imageURL : String){
        guard let postImage = selectedImage else { return }
        guard let caption = textView.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid)
        
        let ref = userPostRef.childByAutoId()
        let values = ["imageURL": imageURL, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String: Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err{
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", err)
                return
            }
            
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
