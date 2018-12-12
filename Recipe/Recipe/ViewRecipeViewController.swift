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
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var PrepTime: UILabel!
    @IBOutlet weak var CookTime: UILabel!
    @IBOutlet weak var Temp: UILabel!
    
    @IBOutlet weak var IngredientTable: UITableView!
    @IBOutlet weak var InstructionTable: UITableView!
    
    @IBOutlet weak var Edit: UIButton!

    
    
    //needed to recieve recipe name from CookBookTableViewController
    var recipeName:String = ""
    var MaxInstructionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Temp.isHidden = true
        Edit.isHidden = true
        //set the recipe name in the viewController's navigation bar
        self.title = recipeName
        
        self.IngredientTable.delegate = self
        self.IngredientTable.dataSource = self
        self.InstructionTable.accessibilityIdentifier = "instruct"
        self.InstructionTable.delegate = self
        self.InstructionTable.dataSource = self
        self.IngredientTable.rowHeight = 50.0
        var currentRecipe:Recipe = Recipe()
        
        do{
            currentRecipe = try Recipe.searchRecipeByName(with: recipeName, in: moc)[0]
        }
        catch{
            print()
        }
        self.PrepTime.text = "Prep Time: " + String(currentRecipe.prepTime)
        self.CookTime.text = "Cook Time: " + String(currentRecipe.cookTime)
        self.RecipeImage.image = UIImage(data: currentRecipe.image!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if( tableView == IngredientTable){
            let cell = self.IngredientTable.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
            do {
                let currentRecipe = try Recipe.searchRecipeByName(with: recipeName, in: moc)[0]
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
        }else{
            let cell = self.InstructionTable.dequeueReusableCell(withIdentifier: "InstructionCell") as! InstructionCell
            do {
                let currentRecipe = try Recipe.searchRecipeByName(with: recipeName, in: moc)[0]
                let instructions = currentRecipe.instructions!.components(separatedBy: "$")
                print(instructions)
                
                cell.StepText.text = instructions[indexPath.row]
            } catch  {
                
            }
            cell.Num.text = String(indexPath.row + 1)
            cell.Num.isHidden = true
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.accessibilityIdentifier == "instruct"{
            do {
                let currentRecipe = try Recipe.searchRecipeByName(with: recipeName, in: moc)[0]
                let instructions = currentRecipe.instructions!.components(separatedBy: "$")
                MaxInstructionCount = instructions.count
                return MaxInstructionCount
            }
            catch{
                print()
            }
            
        }
        else{
            do{
                let currentRecipe = try Recipe.searchRecipeByName(with: recipeName, in: moc)[0]
                let ingredients = try Ingredient.findRecipeIngredients(for: currentRecipe.name!, in: moc)
                return ingredients.count
            }
            catch{
                print()
            }
        }
        return 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is InstructionStepViewController{
            let view = segue.destination as? InstructionStepViewController
                        
            let currCell = InstructionTable.cellForRow(at: InstructionTable.indexPathForSelectedRow!) as! InstructionCell
            
            view?.StepText = currCell.StepText.text!
            view?.StepCount = Int(currCell.Num.text!)!
            
            view?.title = self.title
            view?.StepCountMax = MaxInstructionCount
            
        }
    }
    
    
    
}
