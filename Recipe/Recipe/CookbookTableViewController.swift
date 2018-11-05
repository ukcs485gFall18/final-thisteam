//
//  CookbookTableViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 11/4/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//https://www.youtube.com/watch?v=-tRQmVkrfHc

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
        
        return cell
    }
}//End class
