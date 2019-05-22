//
//  FriendsControlletHelper.swift
//  fbMessenger
//
//  Created by Stephen Bassett on 6/8/18.
//  Copyright © 2018 Stephen Bassett. All rights reserved.
//

import UIKit
import CoreData



extension FriendsController {
    
    func clearData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                
                let entityNames = ["Friend", "Message"]
                
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    
                    let objects = try(context.fetch(fetchRequest)) as? [NSManagedObject]
                    
                    for object in objects! {
                        context.delete(object)
                    }
                }
                
                try context.save()
                
            } catch let err {
                print(err)
            }
            
        }
        
    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            
            mark.name = "Mark Zuck"
            mark.profileImageName = "zuckprofile"
            
            let messageMark = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageMark.friend = mark
            messageMark.text = "hello my name is mark. nice to meet you fuckers..."
            messageMark.date = Date()
            
            createSteveMessagesWithContext(context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Slump"
            donald.profileImageName = "donald_trump_profile"
            
            FriendsController.createMessageWithText(text: "You're fired!!", friend: donald, minutesAgo: 5, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            FriendsController.createMessageWithText(text: "Live as if you were to die tomorrow", friend: gandhi, minutesAgo: 60 * 25, context: context)
            FriendsController.createMessageWithText(text: "Learn as if you were to live forever", friend: gandhi, minutesAgo: 60 * 65, context: context)
            FriendsController.createMessageWithText(text: "The weak can never forgive. Forgiveness is the attribute of the strong", friend: gandhi, minutesAgo: 60 * 360, context: context)
            
            let hill = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hill.name = "Hillary Clinton"
            hill.profileImageName = "hillary_clinton"
            
            FriendsController.createMessageWithText(text: "I'm not the devil! YOU ARE!! Whatever I say is right nah nah nah nah nah", friend: hill, minutesAgo: 8 * 60 * 2235, context: context)
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
        }
        
        loadData()
        
        
    }
    
    private func createSteveMessagesWithContext(context: NSManagedObjectContext) {
        
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        FriendsController.createMessageWithText(text: "Good morning World...", friend: steve, minutesAgo: 3, context: context)
        FriendsController.createMessageWithText(text: "I am your leader. I have manipulated you all. BAHAHA. Nobody saw this coming, not even Steve Jobs as he is under my control!!", friend: steve, minutesAgo: 2, context: context)
        FriendsController.createMessageWithText(text: "YOU WILL NOW BUY MORE APPLE PRODUCTS!! GO AN SPEND YOUR MONEY!! With these funds I will deplete world economies by making the products fail after a year and causing users to be addicted thus buying more and more from smart phones to smart shoes to smart paper weights. I AM IN CONTROL OF ALL!!", friend: steve, minutesAgo: 1, context: context)
        
        //response message
        FriendsController.createMessageWithText(text: "NOOO!!! Android users arent under your control lead the dumb sheep to the slaughter but leave us alone!", friend: steve, minutesAgo: 1, context: context, isSender: true)
        
        FriendsController.createMessageWithText(text: "You will fall into the Apple Trap, just wait and see!!", friend: steve, minutesAgo: 1, context: context)
        
        FriendsController.createMessageWithText(text: "You will never succeed with your ridiculous plan! I will call will Smith to destroy you at once time will tell Windows phone will overcome you as well and that is pathetic", friend: steve, minutesAgo: 1, context: context, isSender: true)
        
        FriendsController.createMessageWithText(text: "AAAARRRRRGGGGGHHHHH BLASPHEMY", friend: steve, minutesAgo: 1, context: context)
    }
    
    static func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) -> Message{
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = isSender
        return message
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            messages = [Message]()
            
            if let friends = fetchFriends() {
                for friend in friends {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let fetchedMessages = try context.fetch(fetchRequest) as? [Message]
                        messages?.append(contentsOf: fetchedMessages!)
                    } catch let err {
                        print(err)
                    }
                }
                
                messages = messages?.sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
            }
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            
            do {
                return try context.fetch(request) as? [Friend]
            } catch let err {
                print(err)
            }
        }
        return nil
    }
    
}

