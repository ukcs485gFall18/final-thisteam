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
    
    var pantry = [
        Ingredient(name: "Egg Noodles", quantity: 1.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
        Ingredient(name: "Chicken Broth", quantity: 8.0, units: .cup, expirationDate: Date.init(timeIntervalSinceNow: 1.577e+7)),
        Ingredient(name: "Carrot", quantity: 5.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 604800)),
        Ingredient(name: "Chicken Breast", quantity: 1.75, units: .lbs, expirationDate: Date.init(timeIntervalSinceNow: 604800)),
        Ingredient(name: "Celery", quantity: 5.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 604800)),
        Ingredient(name: "Black Pepper", quantity: 5.0, units: .tbsp, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
        Ingredient(name: "Egg", quantity: 12.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 1.21e+6)),
        Ingredient(name: "Milk", quantity: 1.0, units: .gal, expirationDate: Date.init(timeIntervalSinceNow: 1.21e+6)),
        Ingredient(name: "Rosemary", quantity: 1.0, units: .oz, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
        Ingredient(name: "Corn Flakes", quantity: 19.0, units: .oz, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
        Ingredient(name: "Rice Noodles", quantity: 8.0, units: .oz, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
        Ingredient(name: "Almond Milk", quantity: 4.0, units: .cup, expirationDate: Date.init(timeIntervalSinceNow: 1.21e+6))
    ]
    
    func load(){
        print("LOADING")
    }
    
    func saveItem(name: String, amount: Double, measure: String, date : Date?){
        if date != nil{
            self.prepareNotification(date: date!, name: name)
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
