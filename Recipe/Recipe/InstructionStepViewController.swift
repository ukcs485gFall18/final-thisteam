//
//  InstructionStepViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 11/4/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
// https://stackoverflow.com/questions/28468906/how-do-i-change-the-text-of-a-button-when-it-is-clicked-swift
// https://stackoverflow.com/questions/18753864/ios-7-back-button-symbol

import Foundation
import UIKit

class InstructionStepViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //increment or decrement the step counter and repopulate the StepTextView
    @IBOutlet weak var Prev: UIButton!
    @IBAction func Prev(_ sender: UIButton) {
        StepCount -= 1
        StepCountLabel.text = "Step \(StepCount)"
        
        //Enable or Disable buttons
        if(StepCount == 1){ Prev.isEnabled = false }
        if(StepCount < StepCountMax){ Next.isEnabled = true }   ///Change values

        
        
    }
    
    @IBOutlet weak var Next: UIButton!
    @IBAction func Next(_ sender: UIButton) {
        StepCount += 1
        StepCountLabel.text = "Step \(StepCount)"
        
        //Enable or disable buttons
        if(StepCount == StepCountMax){ Next.isEnabled = false }
        if(StepCount > 1){ Prev.isEnabled = true } //Change values
        
        
    }
    
    @IBOutlet weak var StepCountLabel: UILabel!
    @IBOutlet weak var StepTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    //needed for Segue
    var StepText:String = ""
    var StepCount: Int = 1
    var StepCountMax: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        StepTextView.isEditable = false
        
        StepTextView.text = StepText
        StepCountLabel.text = "Step \(StepCount)"
        if(StepCount == 1){ Prev.isEnabled = false}
        
        //Set the information based on the cell clicked in the ViewRecipeViewController's InstructionTable
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
        do {
            let currentRecipe = try Recipe.searchRecipeByName(with: self.title!, in: moc)[0]
            let ingredients = try Ingredient.findRecipeIngredients(for: currentRecipe.name!, in: moc)
            cell.IngredientLabel.text = ingredients[indexPath.row].name!
            cell.Amount.text = String(ingredients[indexPath.row].quantity) + " " + ingredients[indexPath.row].units!
        } catch {
            print("Error")
        }
        /* if ingredient in pantry: change image to checkmark
         cell.InPantryImg
         */
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        do {
            let currentRecipe = try Recipe.searchRecipeByName(with: self.title!, in: moc)[0]
            let ingredients = try Ingredient.findRecipeIngredients(for: currentRecipe.name!, in: moc)
            count = ingredients.count
        } catch {
            print("Error")
        }
        return count
    }
}
