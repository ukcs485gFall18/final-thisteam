//
//  Ingredient.swift
//  Recipe
//
//  Created by Adam Brassfield + Ryan Gaines on 12/10/18.
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
    // copied into pantry model, some reason it only works there 
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
    
    // Searches for existing ingredients by name. If none found, it creates a new ingredient
    static func createOrFindRecipeIngredient(with ingredient: Ingredient, in moc: NSManagedObjectContext) throws -> Ingredient {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", ingredient.name!)
        do {
            let results = try moc.fetch(request)
            if results.count > 0 {
                return ingredient
            }
        } catch {
            throw error
        }
        
        let newIngredient = Ingredient(context: moc)
        newIngredient.name = ingredient.name
        newIngredient.quantity = ingredient.quantity
        newIngredient.units = ingredient.units
        newIngredient.inPantry = false
        do {
            try moc.save()
        } catch {
            print("Error saving data!")
        }
        return newIngredient
    }
    
    // Searches for Ingredients associated with a given recipe name
    static func findRecipeIngredients(for recipeName: String, in moc: NSManagedObjectContext) throws -> [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "ANY usedIn.name = %@", recipeName)
        do {
            let request = try moc.fetch(request)
            return request
        } catch {
            throw error
        }
    }
    
    // Similar to create Ingredient, except it searches for an existing ingredient and adds the new information to what it finds
    static func updateIngredient(with ingredientInfo: [String], in moc: NSManagedObjectContext) {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", ingredientInfo[0])
        do {
            let result = try moc.fetch(request)
            result[0].quantity = Double(ingredientInfo[1])!
            result[0].units = ingredientInfo[2]
            result[0].inPantry = Bool(ingredientInfo[3])!
            try moc.save()
        } catch {
            print("Error saving data!")
        }
    }
    
    
    //https://stackoverflow.com/questions/38017449/swift-3-core-data-delete-object
    static func deleteIngredient(with ingredientInfo: [String], in moc: NSManagedObjectContext){
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", ingredientInfo[0])
        do{
            let result = try moc.fetch(request)
            for object in result as [NSManagedObject]{
                    moc.delete(object)
            }
        } catch{
            print("Error deleting")
        }
        
        do{
            try moc.save()
        } catch{
            print("error")
        }
        
    }
}
