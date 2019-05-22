//
//  CustomTabBarController.swift
//  fbMessenger
//
//  Created by Stephen Bassett on 6/14/18.
//  Copyright © 2018 Stephen Bassett. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup out custome view controllers
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
        
        
        
        viewControllers = [recentMessagesNavController,
                           createDummyNavControllerWithTitle(title: "Calls", imageName: "calls"),
                           createDummyNavControllerWithTitle(title: "Groups", imageName: "groups"),
                           createDummyNavControllerWithTitle(title: "People", imageName: "people"),
                           createDummyNavControllerWithTitle(title: "Settings", imageName: "settings")]
        
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
