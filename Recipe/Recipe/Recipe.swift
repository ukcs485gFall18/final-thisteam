//
//  Recipe.swift
//  Recipe
//
//  Created by Adam Brassfield on 10/16/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import UIKit
import Foundation

enum Categories {
    
}

struct Recipe {
    var name: String
    var ingredients: [Ingredient]
    var instructions: [String]
    var image: UIImage
    var rating: Double
    var categories: [Categories]
}
