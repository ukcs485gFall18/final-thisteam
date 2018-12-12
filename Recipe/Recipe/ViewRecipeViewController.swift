//
//  ViewRecipeViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 11/4/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
// https://stackoverflow.com/questions/25167458/changing-navigation-title-programmatically
// https://stackoverflow.com/questions/18953509/how-to-prevent-uinavigationbar-from-covering-top-of-view-in-ios-7



import Foundation
import UIKit

class ViewRecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    /******************/
    //temp! take out later
    var items = ["one","two","three"]
    /******************/
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var PrepTime: UILabel!
    @IBOutlet weak var CookTime: UILabel!
    @IBOutlet weak var Temp: UILabel!
    
    @IBOutlet weak var IngredientTable: UITableView!
    @IBOutlet weak var InstructionTable: UITableView!
    
    @IBOutlet weak var Edit: UIButton!
    
    
    //needed to recieve recipe name from CookBookTableViewController
    var recipeName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the recipe name in the viewController's navigation bar
        self.title = recipeName
        
        self.IngredientTable.delegate = self
        self.IngredientTable.dataSource = self
        
        self.InstructionTable.delegate = self
        self.InstructionTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if( tableView == IngredientTable){
            let cell = self.IngredientTable.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
            cell.IngredientLabel.text = self.items[indexPath.row]
            cell.Amount.text = "2 tsp"
            /* if ingredient in pantry: change image to checkmark
                cell.InPantryImg
            */
            return cell
        }else{
            let cell = self.InstructionTable.dequeueReusableCell(withIdentifier: "InstructionCell") as! InstructionCell
            cell.StepText.text = self.items[indexPath.row]
            cell.Num.text = String(indexPath.row + 1)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is InstructionStepViewController{
            let view = segue.destination as? InstructionStepViewController
                        
            let currCell = InstructionTable.cellForRow(at: InstructionTable.indexPathForSelectedRow!) as! InstructionCell
            
            view?.StepText = currCell.StepText.text!
            view?.StepCount = Int(currCell.Num.text!)!
            
            view?.title = self.title
            
        }
    }
    
    
    
}
