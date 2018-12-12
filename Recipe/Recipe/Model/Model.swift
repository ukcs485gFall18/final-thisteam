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

let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
var moc: NSManagedObjectContext = container.viewContext
