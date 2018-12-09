//
//  viewPantryController.swift
//  Recipe
//
//  Created by Ryan Gaines on 12/9/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

// view controller for viewing contents of pantry

import Foundation
import UIKit

class viewPantryContentsController: UIViewController{
    var model:pantryModel = pantryModel()
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sortData(_ sender: Any) {
        let sortAlert = UIAlertController(title: "Sort", message: "How do you want to sort the pantry?", preferredStyle: .alert)
        let sortByName = UIAlertAction(title: "Name", style: .default) { (action:UIAlertAction) in
            print("You've pressed name");
        }
        let sortByAmount = UIAlertAction(title: "Amount", style: .default) { (action:UIAlertAction) in
            print("You've pressed Amount");
        }
        let sortByExpire = UIAlertAction(title: "Expiration Date", style: .default) { (action:UIAlertAction) in
            print("You've pressed expire");
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        sortAlert.addAction(sortByName)
        sortAlert.addAction(sortByAmount)
        sortAlert.addAction(sortByExpire)
        sortAlert.addAction(cancel)
        self.present(sortAlert, animated: true, completion: nil)
    }
    
}
