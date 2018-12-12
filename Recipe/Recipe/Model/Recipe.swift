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
    static func createRecipe(with recipeInfo: [String], using ingredients: [Ingredient], and recipeImage: UIImage?, in moc: NSManagedObjectContext) {
        let recipe = Recipe(context: moc)
        recipe.name = recipeInfo[0]
        recipe.prepTime = Double(recipeInfo[1])!
        recipe.cookTime = Double(recipeInfo[2])!
        recipe.instructions = recipeInfo[3]
        recipe.image = recipeImage?.pngData()
        
        // Updated to save ingredients when adding them to a recipe
        for ingredient in ingredients {
            do {
                try recipe.addToUses(Ingredient.createOrFindRecipeIngredient(with: ingredient, in: moc))
            } catch {
                print("Error saving data!")
            }
        }
        
        do {
            try moc.save()
        } catch {
            print("Error saving data!")
        }
    }
    
    // Similar to create recipe, except it searches for an existing recipe and adds the new information to what it finds
    static func updateRecipe(with recipeInfo: [String], in moc: NSManagedObjectContext) {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", recipeInfo[0])
        do {
            let result = try moc.fetch(request)
            result[0].prepTime = Double(recipeInfo[1])!
            result[0].cookTime = Double(recipeInfo[2])!
            result[0].instructions = recipeInfo[3]
            try moc.save()
        } catch {
            print("Error saving data!")
        }
    }
    
    
    // filterRecipesByPantryItems lists all recipes saved to the device which are then sorted by by how many ingredients they have in the pantry
    static func filterRecipesByPantryItems(in moc: NSManagedObjectContext) throws -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(value: true)
        do {
            var results = try moc.fetch(request)
            results.sort(by: {$0.uses!.count > $1.uses!.count})
            return results
        } catch {
            throw error
        }
    }
    
    // searchRecipeByName lists all recipes whose names contain a string passed to the function
    static func searchRecipeByName(with name: String, in moc: NSManagedObjectContext) throws -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "name contains %@", name)
        do {
            var results = try moc.fetch(request)
            results.sort(by: {$0.uses!.count > $1.uses!.count})
            return results
        } catch {
            throw error
        }
    }
    
    // searchByRecipeByCategory lists all recipes who are associated with a given category
    static func searchRecipeByCategory(with name: String, in moc: NSManagedObjectContext) throws -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "ANY category.name = %@", name)
        do {
            var results = try moc.fetch(request)
            results.sort(by: {$0.uses!.count > $1.uses!.count})
            return results
        } catch {
            throw error
        }
    }
}
