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
import CoreData
import UIKit

class pantryModel{
    
    var pantry:[Ingredient] = []
    var filteredPantry:[Ingredient] = []
    
    func load(){
        var res:[Ingredient] = []
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "inPantry == true")
        request.sortDescriptors = [NSSortDescriptor(key: "expiration", ascending: true)]
        do {
            let results = try moc.fetch(request)
            res = results
        } catch {
            print("error")
        }
        
        var second:[Ingredient] = []
        for i in res{
            if i.inPantry{
                second.append(i)
                print(i.inPantry)
            }
        }
        
        self.pantry = second

    }
    
    func saveItem(name: String, amount: Double, measure: String, date : Date?){
        if date != nil{
            self.prepareNotification(date: date!, name: name)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let strDate = formatter.string(from: date!)
            container.performBackgroundTask{ context in
                Ingredient.createIngredient(with: [name, String(amount), measure, "true", strDate ], in: context)
            }
            
        }
        else{
            Ingredient.createIngredient(with: [name, String(amount), measure, "true", ""], in: moc)
        }
        let addition = Ingredient(context: moc)
        addition.name = name
        addition.quantity = amount
        addition.units = measure
        addition.expiration = date
        self.pantry.append(addition)
    
        //afraid to delete b/c it is working
        for i in self.pantry{
            print(i.name as Any)
        }
        
    }
    
    func updateItem(itemNew: Ingredient, itemOld: Ingredient){
        let index = self.pantry.index(where: {$0 == itemOld})
        self.pantry[index!] = itemNew
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var strDate:String = ""
        if let date = itemNew.expiration{
            strDate = formatter.string(from: date)
        }
        else{
            strDate = ""
        }
        container.performBackgroundTask{ context in
            Ingredient.updateIngredient(with: [itemNew.name!, String(itemNew.quantity), itemNew.units!, "true", strDate], in: context)
        }
        
    }
    func deletItem(Item: Ingredient){
        if Item.expiration != nil{
            self.removeNotification(Item: Item)
        }
        let index = self.pantry.index(where: {$0 == Item})
        self.pantry.remove(at: index!)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var strDate:String = ""
        if let date = Item.expiration{
            strDate = formatter.string(from: date)
        }
        else{
            strDate = ""
        }
        container.performBackgroundTask{ context in
            Ingredient.deleteIngredient(with: [Item.name!, String(Item.quantity), Item.units!, "true", strDate], in: context)
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
            let sorted:[Ingredient] = self.pantry.sorted{ $0.name!.lowercased() < $1.name!.lowercased()}
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

