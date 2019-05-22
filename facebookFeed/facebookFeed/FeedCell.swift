//
//  FeedCell.swift
//  facebookFeed
//
//  Created by Stephen Bassett on 6/6/18.
//  Copyright © 2018 Stephen Bassett. All rights reserved.
//

import Foundation
import UIKit

//var imageCache = [String: UIImage]() //doing cache manually this way requires clearing cache in memory warning func in the VC
//var imageCache = NSCache<AnyObject, UIImage>()

class FeedCell: UICollectionViewCell {
    
    var feedController: FeedController?
    
    @objc func animate() {
        feedController?.animateImageView(statusImageView: statusImageView)
        
    }
    
    var post: Post? {
        didSet {
            
            statusImageView.image = nil
            loader.startAnimating()
            
            if let statusImageUrl = post?.statusImageUrl {
                
                // One way to cache
//                if let image = imageCache[statusImageUrl] {
//                    statusImageView.image = image
//                    self.loader.stopAnimating()
//                } else {
                // Another way to cache
//                if let image = imageCache.object(forKey: statusImageUrl as AnyObject) {
//                    statusImageView.image = image
//                    loader.stopAnimating()
//                } else {
//                Both these above ways to cache have their ups and downs.
//                Currently cache is implemented by imcreasing the default amount that URLSession can cache
//                This was done in the FeedController Class
                
                URLSession.shared.dataTask(with: URL(string: statusImageUrl)!, completionHandler: { (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    let image = UIImage(data: data!)
                    
//                      imageCache[statusImageUrl] = image
//                      imageCache.setObject(image!, forKey: statusImageUrl as AnyObject)
                    
                    DispatchQueue.main.async { () -> Void in
                        self.statusImageView.image = image
                        self.loader.stopAnimating()
                    }
                    
                    
                }).resume()
                    
//                }
                
                
            }
            
            setupNameLocationStatusAndProfileImage()
        }
    }
    
    private func setupNameLocationStatusAndProfileImage() {
        
        if let name = post?.name {
            
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            
//            if let city = post?.location?.city, let state = post?.location?.state {
//                attributedText.append(NSAttributedString(string: "\n\(city), \(state)  •  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 161)]))
                attributedText.append(NSAttributedString(string: "\nDecember 18  •  San Francisco  •  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 161)]))
            
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
//            }
            
            nameLabel.attributedText = attributedText
            
        }
        
        if let statusText = post?.statusText {
            statusTextView.text = statusText
        }
        
        if let profileImagename = post?.profileImageName {
            profileImageView.image = UIImage(named: profileImagename)
        }
        
        if let statusImageName = post?.statusImageName {
            statusImageView.image = UIImage(named: statusImageName)
        }
        
        if let numLikes = post?.numLikes, let numComments = post?.numComments {
            likesCommentsLabel.text = "\(numLikes) Likes  \(numComments) Comments"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
//        textView.text = "Meanwhile, Beast turned to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
//        label.text = "488 Likes   10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like")
    let commentButton: UIButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    let shareButton: UIButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        setupStatusImageViewLoader()
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animate)))
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        //button constraints
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
    }
    
    let loader = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    func setupStatusImageViewLoader() {
        loader.hidesWhenStopped = true
        loader.startAnimating()
        loader.color = UIColor.black
        statusImageView.addSubview(loader)
        statusImageView.addConstraintsWithFormat(format: "H:|[v0]|", views: loader)
        statusImageView.addConstraintsWithFormat(format: "V:|[v0]|", views: loader)
    }
    

}
