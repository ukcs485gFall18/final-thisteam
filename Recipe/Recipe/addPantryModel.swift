//
//  addPantryModel.swift
//  Recipe
//
//  Created by Ryan Gaines on 12/8/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//
// Model that deals with both adding and viewing pantry model

import Foundation
import UserNotifications


class pantryModel{
    
    //test pantry
    
    var pantry:[Ingredient] = []
    var filteredPantry:[Ingredient] = []
    
    func load(){
        print("LOADING")
        
    }
    
    func saveItem(name: String, amount: Double, measure: String, date : Date?){
        if date != nil{
            self.prepareNotification(date: date!, name: name)
        }
    }
    
    func updateItem(item: Ingredient){
        
    }
    func deletItem(Item: Ingredient){
        if Item.expiration != nil{
            self.removeNotification(Item: Item)
        }
    }
    
    
    // https://stackoverflow.com/questions/40562912/usernotifications-cancel-swift3
    func removeNotification(Item: Ingredient){
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var removeThis: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                let date = Item.expiration!
                let calendar = Calendar.current
                var components = calendar.dateComponents([.day, .month, .year], from: date as Date)
                if notification.identifier == Item.name! + String(components.month!) + "/" + String(components.day!) + "/" + String(components.year!) {
                    removeThis.append(notification.identifier)
                }
            }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: removeThis)
            
        }
    }
    
    //https://www.hackingwithswift.com/example-code/arrays/how-to-sort-an-array-using-sort
    func sortOn(val: String)-> Void{
        if val == "name"{
            let sorted:[Ingredient] = self.pantry.sorted{ $0.name! < $1.name!}
            self.pantry = sorted
        }
        else{
            //https://stackoverflow.com/questions/47255246/sorting-struct-array-in-swift-4
            let sorted:[Ingredient] = self.pantry.sorted(by: {(lhs, rhs)->Bool in
                if let lhsDate = lhs.expiration, let rhsDate = rhs.expiration{
                    return lhsDate < rhsDate
                }
                if lhs.expiration == nil && rhs.expiration == nil{
                    return false
                }
                if lhs.expiration == nil{
                    return false
                }
                if rhs.expiration == nil{
                    return true
                }
                return false //never ran but needed for code
            })
            self.pantry = sorted
        }
    }
    
    //https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html
    func prepareNotification(date: Date, name: String){
        let content = UNMutableNotificationContent()
        content.title = "Expire Notification"
        content.body = "Yout \(name) is expired! Please throw it out!"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .month, .year], from: date as Date)
        components.hour = 12
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: name + String(components.month!) + "/" + String(components.day!) + "/" + String(components.year!), content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in print(error as Any)
        }
        
        
    }

    
}

