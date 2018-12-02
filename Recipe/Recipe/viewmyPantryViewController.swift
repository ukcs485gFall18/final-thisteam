//
//  viewmyPantryViewController.swift
//  Recipe
//
//  Created by Ryan Gaines on 10/28/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//
// based off video https://www.youtube.com/watch?v=-tRQmVkrfHc


import Foundation
import UIKit

class viewmyPantryViewController : UITableViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //prevents controls from getting shoved under the navigation bar
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantry.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pantryCell") as! myPantryCell
        
        cell.cellLabel.text = pantry[indexPath.row].name
        return cell
    }
    
}
