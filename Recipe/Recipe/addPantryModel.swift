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
        var expireDate = Calendar.current.dateComponents([.year,.month,.day], from: date)
        //default to notifcations at noon
        expireDate.hour = 12
        expireDate.minute = 0
        expireDate.second = 0
        
        let content = UNMutableNotificationContent()
        content.title =  NSString.localizedUserNotificationString(forKey: "Food Expiration Warning!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "\(name) has expired! Please remove this from your pantry!",arguments: nil)
        
        let expireTrigger = UNCalendarNotificationTrigger(dateMatching: expireDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "expired", content: content, trigger: expireTrigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        
    }

    
}

