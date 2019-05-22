//
//  Posts.swift
//  facebookFeed
//
//  Created by Stephen Bassett on 6/6/18.
//  Copyright © 2018 Stephen Bassett. All rights reserved.
//


import Foundation

import Foundation

class Post: SafeJsonObject {
    @objc var name: String?
    @objc var profileImageName: String?
    @objc var statusText: String?
    @objc var statusImageName: String?
    @objc var numLikes: NSNumber?
    @objc var numComments: NSNumber?
    @objc var location: Location?
    @objc var statusImageUrl: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeys(value as! [String: Any])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}
class Location: NSObject {
    @objc var city: String?
    @objc var state: String?
}
//class Posts {
//    
//    private let postsList: [Post]
//    
//    init() {
//        let postMark = Post()
//        postMark.name = "Mark Zuckerberg"
//        postMark.location = Location()
//        postMark.location?.city = "San Francisco"
//        postMark.location?.state = "CA"
//        postMark.profileImageName = "zuckprofile"
//        postMark.statusText = "By giving people the power to share, we're making the world more transparent."
//        postMark.statusImageName = "mark_zuckerberg_background"
//        postMark.numLikes = 400
//        postMark.numComments = 123
//        postMark.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg"
//        
//        let postSteve = Post()
//        postSteve.name = "Steve Jobs"
//        postSteve.location = Location()
//        postSteve.location?.city = "Cupertino"
//        postSteve.location?.state = "CA"
//        postSteve.profileImageName = "steve_profile"
//        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" +
//            "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" +
//        "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
//        postSteve.statusImageName = "steve_status"
//        postSteve.numLikes = 1000
//        postSteve.numComments = 55
//        postSteve.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg"
//        
//        let postGandhi = Post()
//        postGandhi.name = "Mahatma Gandhi"
//        postGandhi.location = Location()
//        postGandhi.location?.city = "Porbandar"
//        postGandhi.location?.state = "India"
//        postGandhi.profileImageName = "gandhi_profile"
//        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n" +
//            "The weak can never forgive. Forgiveness is the attribute of the strong.\n" +
//        "Happiness is when what you think, what you say, and what you do are in harmony."
//        postGandhi.statusImageName = "gandhi_status"
//        postGandhi.numLikes = 333
//        postGandhi.numComments = 22
//        postGandhi.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg"
//        
//        let postBillGates = Post()
//        postBillGates.name = "Bill Gates"
//        postBillGates.location = Location()
//        postBillGates.location?.city = "Portland"
//        postBillGates.location?.state = "OR"
//        postBillGates.profileImageName = "bill_gates_profile"
//        postBillGates.statusText = "Success is a lousy teacher. It seduces smart people into thinking they can't lose.\n\n" +
//            "Your most unhappy customers are your greatest source of learning.\n\n" +
//        "As we look ahead into the next century, leaders will be those who empower others."
//        postBillGates.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gates_background.jpg"
//        
//        let postTimCook = Post()
//        postTimCook.name = "Tim Cook"
//        postTimCook.location = Location()
//        postTimCook.location?.city = "Cupertino"
//        postTimCook.location?.state = "CA"
//        postTimCook.profileImageName = "tim_cook_profile"
//        postTimCook.statusText = "The worst thing in the world that can happen to you if you're an engineer that has given his life to something is for someone to rip it off and put their name on it."
//        postTimCook.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/Tim+Cook.png"
//        
//        let postDonaldTrump = Post()
//        postDonaldTrump.name = "Donald Trump"
//        postDonaldTrump.location = Location()
//        postDonaldTrump.location?.city = "DumbVille"
//        postDonaldTrump.location?.state = "USA"
//        postDonaldTrump.profileImageName = "donald_trump_profile"
//        postDonaldTrump.statusText = "An ‘extremely credible source’ has called my office and told me that Barack Obama’s birth certificate is a fraud."
//        postDonaldTrump.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/trump_background.jpg"
//        
//        postsList = [postMark, postSteve, postGandhi, postBillGates, postTimCook, postDonaldTrump]
//    }
//    
//    func numberOfPosts() -> Int {
//        return postsList.count
//    }
//    
//    subscript(indexPath: NSIndexPath) -> Post {
//        get {
//            return postsList[indexPath.item]
//        }
//    }
//}
