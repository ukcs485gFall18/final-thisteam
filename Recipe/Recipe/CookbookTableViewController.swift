//
//  CookbookTableViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin + Brassfield, Adam on 11/4/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
// https://www.youtube.com/watch?v=-tRQmVkrfHc
// https://stackoverflow.com/questions/26158768/how-to-get-textlabel-of-selected-row-in-swift
// https://stackoverflow.com/questions/40945889/how-to-send-information-from-custom-cells-to-a-view-controller

import Foundation
import UIKit
import CoreData

class CookbookTableViewController : UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //return the number of recipes in the cookbook
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try Recipe.filterRecipesByPantryItems(in: moc).count
        } catch {
            return 0
        }
    }
    
    //set the information for each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //initialize a cell of the proper type
        let cell = tableView.dequeueReusableCell(withIdentifier: "CookbookTableViewCell") as! CookbookTableViewCell
        
        //set the sub elements of the cell (Label, image, etc)
        do {
            cell.CellLabel.text = try Recipe.filterRecipesByPantryItems(in: moc)[indexPath.row].name
        } catch {
            print("Error!")
        }
        
        //if the recipe has a custom image, set it, otherwise maintain default image (defaultRecipeImage.png)
        do {
            if (try Recipe.filterRecipesByPantryItems(in: moc)[indexPath.row].image == nil) {
                cell.CellImage.image = UIImage(named: "defaultImage")
            } else {
                cell.CellImage.image = try UIImage(data: Recipe.filterRecipesByPantryItems(in: moc)[indexPath.row].image!)
            }
        } catch {
            print("Error!")
        }
        
        //populate the tableView
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if the segue is going to ViewRecipeViewController, send the currentCell's recipe name
        if segue.destination is ViewRecipeViewController{
            let view = segue.destination as? ViewRecipeViewController
            
            //find out which cell was clicked
            let currCell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! CookbookTableViewCell

            view?.recipeName = currCell.CellLabel.text!
        }
    }
    
}//End class
