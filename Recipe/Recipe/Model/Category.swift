//
//  Category.swift
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

// createCategory takes in an array of data and assigns it to a variable of type Category that is then saved to the device
class Category: NSManagedObject {
    static func createCategory(with name: String, in moc: NSManagedObjectContext) {
        let category = Category(context: moc)
        category.name = name
        do {
            try moc.save()
        } catch {
            print("Error saving data!")
        }
    }
}
