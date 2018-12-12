//
//  Model.swift
//  Recipe
//
//  Created by Adam Brassfield on 12/11/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/*
 References used:
 Apple CoreData Documentation available at https://developer.apple.com/documentation/coredata
 Lectures 10 (CoreData) and 11 (CoreData Demo) in Developing iOS 10 Apps with Swift by Stanford University available at https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120
 */

// Container & context used throughout app
let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
var moc: NSManagedObjectContext = container.viewContext

func setDummyData() {
        let ingredient1 = Ingredient(context: moc)
        ingredient1.name = "Banana"
        ingredient1.quantity = 3
        ingredient1.units = "oz"
        ingredient1.inPantry = true
        ingredient1.expiration = Date()
        
        let ingredient2 = Ingredient(context: moc)
        ingredient2.name = "Oatmeal"
        ingredient2.quantity = 2
        ingredient2.units = "cups"
        ingredient2.inPantry = true
        ingredient2.expiration = Date()
        
        let ingredient3 = Ingredient(context: moc)
        ingredient3.name = "Peanut Butter"
        ingredient3.quantity = 3
        ingredient3.units = "oz"
        ingredient3.inPantry = true
        ingredient3.expiration = Date()
        
        let ingredients = [ingredient1, ingredient2, ingredient3]
        let recipe = ["Peanut Butter Banana Oatmeal", "0", "5", "Cook oatmeal, add additional ingredients"]
        Recipe.createRecipe(with: recipe, using: ingredients, and: nil, in: moc)
}
