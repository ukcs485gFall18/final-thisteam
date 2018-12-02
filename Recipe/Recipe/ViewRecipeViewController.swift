//
//  ViewRecipeViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 11/4/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
// https://stackoverflow.com/questions/25167458/changing-navigation-title-programmatically


import Foundation
import UIKit

class ViewRecipeViewController: UIViewController{
    @IBOutlet weak var RecipeImage: UIImageView!

    @IBOutlet weak var Ingredients: UITextView!
    
    @IBOutlet weak var StepCell: UITableView!
    @IBOutlet weak var Label: UILabel?
    
    //needed to recieve recipe name from CookBookTableViewController
    var recipeName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the recipe name in the viewController's navigation bar
        self.title = recipeName
        
    }
    
    
}
