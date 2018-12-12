//
//  Ingredient.swift
//  Recipe
//
//  Created by Adam Brassfield on 12/10/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

/*
 References used:
 Apple CoreData Documentation available at https://developer.apple.com/documentation/coredata
 Apple DateFormatter Documentation available at https://developer.apple.com/documentation/foundation/dateformatter
 Lectures 10 (CoreData) and 11 (CoreData Demo) in Developing iOS 10 Apps with Swift by Stanford University available at https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120
 */

import UIKit
import CoreData

class Ingredient: NSManagedObject {
    // loadPantry lists all ingredients where the items are in the pantry, sorted by expiration
    static func loadPantry(in moc: NSManagedObjectContext) throws -> [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "inPantry == YES")
        request.sortDescriptors = [NSSortDescriptor(key: "expiration", ascending: true)]
        do {
            let results = try moc.fetch(request)
            return results
        } catch {
            throw error
        }
    }
    
    
    // createIngredient takes in an array of data and assigns it to a variable of type Ingredient that is then saved to the device
    static func createIngredient(with ingredientInfo: [String], in moc: NSManagedObjectContext) {
        let ingredient = Ingredient(context: moc)
        ingredient.name = ingredientInfo[0]
        ingredient.quantity = Double(ingredientInfo[1])!
        ingredient.units = ingredientInfo[2]
        ingredient.inPantry = Bool(ingredientInfo[3])!
        
        
        
        // Use dateFormatter to convert string to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        ingredient.expiration = formatter.date(from: ingredientInfo[4])
        
        do {
            try moc.save()
        } catch {
            print("Error saving data!")
        }
    }
    
    static func updateIngredient(with ingredientInfo: [String], in moc: NSManagedObjectContext) {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", ingredientInfo[0])
        do {
            let result = try moc.fetch(request)
            result[1].quantity = Double(ingredientInfo[1])!
            result[2].units = ingredientInfo[2]
            result[3].inPantry = Bool(ingredientInfo[3])!
            try moc.save()
        } catch {
            print("Error saving data!")
        }
    }
}
