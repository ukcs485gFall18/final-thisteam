//
//  Recipe.swift
//  Recipe
//
//  Created by Adam Brassfield on 10/16/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import UIKit
import Foundation

enum MeasurementUnits {
    
}

struct Ingredient {
    var name: String
    var quantity: Double
    var units: MeasurementUnits
}

struct Recipe {
    var name: String
    var ingredients: [Ingredient]
    var instructions: [String]
    var image: UIImage
}
