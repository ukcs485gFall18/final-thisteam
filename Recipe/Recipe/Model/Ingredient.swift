//
//  Ingredient.swift
//  Recipe
//
//  Created by Adam Brassfield on 10/16/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation

enum MeasurementUnits {
    
}

struct Ingredient {
    var name: String
    var quantity: Double
    var units: MeasurementUnits?
    var expirationDate: Date
}
