//
//  ViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 10/11/18.
//  Copyright © 2018 Jones, Caitlin All rights reserved.
//Resourses: 
//

import UIKit

class SuperViewController: UIViewController {
    
    public var myPantryModel = pantryModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myPantryModel.load()
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "addPantry" || segue.identifier == "viewPantry"{
            print("ADD")
            if let destination = segue.destination as? pantryViewController{
                destination.model = self.myPantryModel
            }
        }
    }
    
}

