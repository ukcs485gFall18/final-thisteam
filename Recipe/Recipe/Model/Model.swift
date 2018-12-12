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
