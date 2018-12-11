//
//  Recipe.swift
//  Recipe
//
//  Created by Adam Brassfield on 12/10/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

/*
 References used:
 Apple CoreData Documentation available at https://developer.apple.com/documentation/coredata
 Lectures 10 (CoreData) and 11 (CoreData Demo) in Developing iOS 10 Apps with Swift by Stanford University available at https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120
 */

import UIKit
import CoreData

class Recipe: NSManagedObject {
     // createRecipe takes in an array of data and assigns it to a variable of type Recipe that is then saved to the device
    static func createRecipe(with recipeInfo: [String], in moc: NSManagedObjectContext) {
        let recipe = Recipe(context: moc)
        recipe.id = Int16(recipeInfo[0])!
        recipe.name = recipeInfo[1]
        recipe.prepTime = Double(recipeInfo[2])!
        recipe.cookTime = Double(recipeInfo[3])!
        recipe.instructions = recipeInfo[4]
        recipe.rating = Int16(recipeInfo[5])!
        
        do {
            try moc.save()
        } catch {
            print("Error saving data!")
        }
    }
    
    
    // filterRecipesByPantryItems lists all recipes saved to the device which are then sorted by by how many ingredients they have in the pantry
    static func filterRecipesByPantryItems(in moc: NSManagedObjectContext) throws -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "YES")
        request.sortDescriptors = [NSSortDescriptor(key: "(ingredient.inPantry == YES).count", ascending: false)]
        do {
            let results = try moc.fetch(request)
            return results
        } catch {
            throw error
        }
    }
    
    // searchRecipeByName lists all recipes whose names contain a string passed to the function
    static func searchRecipeByName(with name: String, in moc: NSManagedObjectContext) throws -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "ANY name contains %@", name)
        request.sortDescriptors = [NSSortDescriptor(key: "(ingredient.inPantry == YES).count", ascending: false)]
        do {
            let results = try moc.fetch(request)
            return results
        } catch {
            throw error
        }
    }
    
    // searchByRecipeByCategory lists all recipes who are associated with a given category
    static func searchRecipeByCategory(with name: String, in moc: NSManagedObjectContext) throws -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "ANY category.name = %@", name)
        request.sortDescriptors = [NSSortDescriptor(key: "(ingredient.inPantry == YES).count", ascending: false)]
        do {
            let results = try moc.fetch(request)
            return results
        } catch {
            throw error
        }
    }
}
