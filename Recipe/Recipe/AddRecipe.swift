//
//  AddRecipe.swift
//  Recipe
//
//  Created by Jones, Caitlin on 12/11/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation
import UIKit

class AddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var ChangeImage: UIButton!
    @IBOutlet weak var NameEdit: UITextField!
    @IBOutlet weak var PrepTimeEdit: UITextField!
    @IBOutlet weak var CookTimeEdit: UITextField!
    @IBOutlet weak var TempEdit: UITextField!
    @IBOutlet weak var IngredientTable: UITableView!
    @IBOutlet weak var InstructionTable: UITableView!
    
    @IBOutlet weak var AddIngredient: UIButton!
    
    var instructions:[String] = [String]()
    var ingredients:[Ingredient] = [Ingredient]()
    
    @IBAction func AddIngredient(_ sender: Any) {
        //Popup a box to add ingredient
        let alertController = UIAlertController(title: "Add Ingredients", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Ingredient Name..."
        })
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Amount..."
        })
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Measure..."
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {alert->Void in
            print("SAVE")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var AddInstruction: UIButton!
    @IBAction func AddInstruction(_ sender: Any) {
        //Popup a box to add Instruction
        let alertController = UIAlertController(title: "Add Instructions!", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter step here..."
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {alert->Void in
            let curr = alertController.textFields![0] as UITextField
            self.instructions.append(curr.text!)
            self.InstructionTable.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    var nameFromSegue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(nameFromSegue != ""){
            NameEdit.text = nameFromSegue
        }
        
        self.IngredientTable.delegate = self
        self.IngredientTable.dataSource = self
        self.IngredientTable.reloadData()
        self.IngredientTable.accessibilityIdentifier = "ingred"
        
        self.InstructionTable.delegate = self
        self.InstructionTable.dataSource = self
        self.InstructionTable.reloadData()
        self.InstructionTable.accessibilityIdentifier = "instruct"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.accessibilityIdentifier == "ingred"{
            return self.ingredients.count
        }
        else{
            return self.instructions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.accessibilityIdentifier == "ingred"{
            let cell = self.IngredientTable.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
            cell.Amount.text = String(self.ingredients[indexPath.row].quantity) + self.ingredients[indexPath.row].units!
            cell.IngredientLabel.text = self.ingredients[indexPath.row].name!
            return cell
        }
        else{
            let cell = self.InstructionTable.dequeueReusableCell(withIdentifier: "InstructionCell") as! InstructionCell
            //cell.Num.text = String(indexPath.row - 1)
            cell.StepText.text = String(indexPath.row + 1) + ")" + " " + self.instructions[indexPath.row]
            return cell
        }
    }
    
}
