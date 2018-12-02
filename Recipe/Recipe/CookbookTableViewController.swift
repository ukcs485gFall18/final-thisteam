//
//  CookbookTableViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 11/4/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
// https://www.youtube.com/watch?v=-tRQmVkrfHc
// https://stackoverflow.com/questions/26158768/how-to-get-textlabel-of-selected-row-in-swift
// https://stackoverflow.com/questions/40945889/how-to-send-information-from-custom-cells-to-a-view-controller

import Foundation
import UIKit

class CookbookTableViewController : UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //return the number of recipes in the cookbook
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CookbookList.count //from ModelDemo
    }
    
    //set the information for each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //initialize a cell of the proper type
        let cell = tableView.dequeueReusableCell(withIdentifier: "CookbookTableViewCell") as! CookbookTableViewCell
        
        //set the sub elements of the cell (Label, image, etc)
        cell.CellLabel.text = CookbookList[indexPath.row].name
        
        //if the recipe has a custom image, set it, otherwise maintain default image (defaultRecipeImage.png)
        if(CookbookList[indexPath.row].image != nil){
            cell.CellImage.image = CookbookList[indexPath.row].image
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
