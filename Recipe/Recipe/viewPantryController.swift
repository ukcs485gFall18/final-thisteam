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

class viewPantryContentsController: UIViewController, UITableViewDataSource,  UITableViewDelegate, UISearchBarDelegate{

    
    var model:pantryModel = pantryModel()
    
    //search bar: https://shrikar.com/swift-ios-tutorial-uisearchbar-and-uisearchbardelegate/
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    var isSearching:Bool = false
    var filteredData:[Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTable.dataSource = self
        self.myTable.delegate = self
        self.search.delegate = self
        self.myTable.rowHeight = 80.0     //https://stackoverflow.com/questions/25632394/swift-uitableview-set-rowheight
        
        self.myTable.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.pantry.count
        
    }
    
    func convertToStr(measure: MeasurementUnits?) ->String{
        switch measure {
        case .cup?:
            return "cup"
        case .gal?:
            return "gallon"
        case .lbs?:
            return "pound"
        case .oz?:
            return "ounce"
        case .tbsp?:
            return "tablespoon"
        case .tsp?:
            return "teaspoon"
        default:
            return "unit"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "myPantryCell") as! pantryCell
        let name = model.pantry[indexPath.row].name
        let amount = model.pantry[indexPath.row].quantity
        let measure = model.pantry[indexPath.row].units
        var measureStr = convertToStr(measure: measure)
        if amount != 1.0{
            measureStr += "s"
        }
        cell.name.text = name
        cell.amount.text = String(amount) + " " + measureStr
        return cell
        
    }
    
}
