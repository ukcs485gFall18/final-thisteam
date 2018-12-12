//
//  ViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 10/11/18.
//  Copyright © 2018 Jones, Caitlin All rights reserved.
//Resourses: 
//

import UIKit
import CoreData

class SuperViewController: UIViewController {
    
    public var myPantryModel = pantryModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myPantryModel.load()
        container.performBackgroundTask { context in
            let recipeData = ["vienna sausages", "12.0", "30.0", "Open the can and voila! It's ready"]
            let ingredient1 = Ingredient(context: moc)
            ingredient1.name = "candy"
            ingredient1.inPantry = true
            ingredient1.expiration = Date()
            ingredient1.quantity = 12
            ingredient1.units = "handfuls"
            let ingredients = [ingredient1]
            Recipe.createRecipe(with: recipeData, using: ingredients, and: nil, in: context)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPantry"{
            if let destination = segue.destination as? pantryViewController{
                destination.model = self.myPantryModel
            }
        }
        else if segue.identifier == "viewPantry"{
            if let destination = segue.destination as? viewPantryContentsController{
                destination.model = self.myPantryModel
            }
        }
    }
    
}


