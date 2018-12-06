//
//  ModelDemo.swift
//  Recipe
//
//  Created by Adam Brassfield on 10/25/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation

// Demo Pantry
var pantry = [
    Ingredient(name: "Egg Noodles", quantity: 1.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
    Ingredient(name: "Chicken Broth", quantity: 8.0, units: .cup, expirationDate: Date.init(timeIntervalSinceNow: 1.577e+7)),
    Ingredient(name: "Carrot", quantity: 5.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 604800)),
    Ingredient(name: "Chicken Breast", quantity: 1.75, units: .lbs, expirationDate: Date.init(timeIntervalSinceNow: 604800)),
    Ingredient(name: "Celery", quantity: 5.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 604800)),
    Ingredient(name: "Black Pepper", quantity: 5.0, units: .tbsp, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
    Ingredient(name: "Egg", quantity: 12.0, units: nil, expirationDate: Date.init(timeIntervalSinceNow: 1.21e+6)),
    Ingredient(name: "Milk", quantity: 1.0, units: .gal, expirationDate: Date.init(timeIntervalSinceNow: 1.21e+6)),
    Ingredient(name: "Rosemary", quantity: 1.0, units: .oz, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
    Ingredient(name: "Corn Flakes", quantity: 19.0, units: .oz, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
    Ingredient(name: "Rice Noodles", quantity: 8.0, units: .oz, expirationDate: Date.init(timeIntervalSinceNow: 3.154e+7)),
    Ingredient(name: "Almond Milk", quantity: 4.0, units: .cup, expirationDate: Date.init(timeIntervalSinceNow: 1.21e+6))
]

// Demo recipe: All ingredients are in the pantry
var testRecipe1 = Recipe(
    id: 1,
    name: "Chicken Noodle Soup",
    prepTime: 15.0,
    cookTime: 45.0,
    ingredients: [
        Ingredient(name: "Chicken Broth", quantity: 8.0, units: .cup, expirationDate: nil),
        Ingredient(name: "Carrot", quantity: 5.0, units: nil, expirationDate: nil),
        Ingredient(name: "Chicken Breast", quantity: 1.75, units: .lbs, expirationDate: nil),
        Ingredient(name: "Celery", quantity: 5.0, units: nil, expirationDate: nil),
        Ingredient(name: "Black Pepper", quantity: 5.0, units: .tbsp, expirationDate: nil),
        Ingredient(name: "Rosemary", quantity: 1.0, units: .oz, expirationDate: nil)
    ],
    instructions: [
        "1. Cut chicken and chop vegetables",
        "2. Simmer vegetables in large pot on medium heat",
        "3. Add Chicken Broth, chicken, and rosemary to pot and bring to a boil",
        "4. Cover the pot with a lid and bring heat to a simmer. Cook for 35 minutes",
        "5. Uncover. Add Egg Noodles and cook for an additional 10 minutes",
        "6. Season with pepper as necessary",
        "7. Serve and enjoy!"
    ],
    image: nil,
    rating: 4.3,
    categories: [.lunch, .dinner]
)

// Demo recipe: Some indgredients are in pantry
var testRecipe2 = Recipe(
    id: 2,
    name: "Fried Chicken",
    prepTime: 30.0,
    cookTime: 25.0,
    ingredients: [
        Ingredient(name: "Vegetable Oil", quantity: 4.0, units: .cup, expirationDate: Date()+150),
        Ingredient(name: "All Purpose Flour", quantity: 3.0, units: .cup, expirationDate: Date()+150),
        Ingredient(name: "Chicken Breast", quantity: 1.75, units: .lbs, expirationDate: Date()+5),
        Ingredient(name: "Buttermilk", quantity: 3.0, units: .cup, expirationDate: Date()+7),
        Ingredient(name: "Black Pepper", quantity: 5.0, units: .tbsp, expirationDate: Date()+150),
        Ingredient(name: "Paprika", quantity: 2.0, units: .tbsp, expirationDate: Date()+150)
    ],
    instructions: [
        "1. Begin heating oil in a deep pan",
        "2. Combine Flour, Black Pepper, and Paprika in a bowl",
        "3. Dip Chicken Breast in Buttermilk and roll in Flour mix. Let sit for 20 minutes",
        "4. Add chicken to oil and cook until coating turns golden brown",
        "5. Reduce heat to simmer and cook an additional 20 minutes",
        "6. Remove chicken and drain grease",
        "7. Serve and enjoy!"
    ],
    image: nil,
    rating: 4.7,
    categories: [.lunch, .dinner, .american]
)

// Demo recipe: No ingredients in pantry
var testRecipe3 = Recipe(
    id: 3,
    name: "Buffalo Chicken Dip",
    prepTime: 2.0,
    cookTime: 20.0,
    ingredients: [
        Ingredient(name: "Hot Sauce", quantity: 0.5, units: .cup, expirationDate: nil),
        Ingredient(name: "Canned Chicken Breast", quantity: 2.0, units: .cup, expirationDate: nil),
        Ingredient(name: "Ranch Dressing", quantity: 0.5, units: .cup, expirationDate: nil),
        Ingredient(name: "Cheddar Cheese", quantity: 2.0, units: .cup, expirationDate: nil)
    ],
    instructions: [
        "1. Preheat oven to 350 degrees",
        "2. Combine all ingredients in a baking dish",
        "3. Bake for 20 minutes",
        "4. Serve and enjoy!"
    ],
    image: nil,
    rating: 3.0,
    categories: nil
)

var CookbookList = [testRecipe1,testRecipe2,testRecipe3]
