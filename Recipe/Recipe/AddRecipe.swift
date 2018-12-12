//
//  AddRecipe.swift
//  Recipe
//
//  Created by Jones, Caitlin on 12/11/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation
import UIKit

class AddRecipeViewController: UIViewController{
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var ChangeImage: UIButton!
    @IBOutlet weak var NameEdit: UITextField!
    @IBOutlet weak var PrepTimeEdit: UITextField!
    @IBOutlet weak var CookTimeEdit: UITextField!
    @IBOutlet weak var TempEdit: UITextField!
    @IBOutlet weak var IngredientTable: UITableView!
    @IBOutlet weak var InstructionTable: UITableView!
    
    @IBOutlet weak var AddIngredient: UIButton!
    @IBAction func AddIngredient(_ sender: Any) {
        //Popup a box to add ingredient
        let alertController = UIAlertController(title: "Add Ingredient", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Enter", style: .default){(_) in
            
            let Ingredient = alertController.textFields?[0].text
            let Amount = alertController.textFields?[1].text
            //self.labelMessage.text = "Ingredient: " + Ingredient! + "Amount: " + Amount!
        }
    }
    
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var AddInstruction: UIButton!
    @IBAction func AddInstruction(_ sender: Any) {
        //Popup a box to add Instruction
    }
    
    
    
    var nameFromSegue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(nameFromSegue != ""){
            NameEdit.text = nameFromSegue
            /* Update fields with information
            RecipeImage =
            PrepTimeEdit.text =
             CookTimeEdit.text =
             TempEdit.text =
             
             
            */
            
        }
        
        /*
        self.IngredientTable.delegate = self
        self.IngredientTable.dataSource = self
        
        self.InstructionTable.delegate = self
        self.InstructionTable.dataSource = self*/
    }
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
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
        return 0
    }*/
    
}
