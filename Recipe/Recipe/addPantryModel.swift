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
        
        //Change with NSPredicate for loading data
        
        pantry = [Ingredient(name: "Egg Noodles", quantity: 1.0, units: nil, expirationDate: nil),
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
            let sorted:[Ingredient] = self.pantry.sorted{ $0.name < $1.name}
            self.pantry = sorted
        }
        else{
            //https://stackoverflow.com/questions/47255246/sorting-struct-array-in-swift-4
            let sorted:[Ingredient] = self.pantry.sorted(by: {(lhs, rhs)->Bool in
                if let lhsDate = lhs.expirationDate, let rhsDate = rhs.expirationDate{
                    return lhsDate < rhsDate
                }
                if lhs.expirationDate == nil && rhs.expirationDate == nil{
                    return false
                }
                if lhs.expirationDate == nil{
                    return false
                }
                if rhs.expirationDate == nil{
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
