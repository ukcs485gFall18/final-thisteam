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
    var sortOn:String = String()
    var selected:Ingredient? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTable.dataSource = self
        self.myTable.delegate = self
        self.search.delegate = self
        self.myTable.rowHeight = 80.0     //https://stackoverflow.com/questions/25632394/swift-uitableview-set-rowheight
        self.myTable.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.filteredPantry = model.pantry.filter{$0.name!.contains(searchText)}
        if searchBar.text?.count != 0{
            isSearching = true
        }
        else{
            isSearching = false
        }
        self.myTable.reloadData()
        
    }

    
    
    @IBAction func sortData(_ sender: Any) {
        let sortAlert = UIAlertController(title: "Sort", message: "How do you want to sort the pantry?", preferredStyle: .alert)
        let sortByName = UIAlertAction(title: "Name", style: .default) { (action:UIAlertAction) in
            self.model.sortOn(val: "name")
            self.myTable.reloadData()
        }
        let sortByExpire = UIAlertAction(title: "Expiration Date", style: .default) { (action:UIAlertAction) in
            self.model.sortOn(val: "expire")
            self.myTable.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print() //had to do something
        }
        sortAlert.addAction(sortByName)
        sortAlert.addAction(sortByExpire)
        sortAlert.addAction(cancel)
        self.present(sortAlert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return model.filteredPantry.count
        }
        return model.pantry.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "myPantryCell") as! pantryCell
        var name:String = String()
        var amount:Double = Double()
        var measure:String? = String()
        if !isSearching{
            name = model.pantry[indexPath.row].name!
            amount = model.pantry[indexPath.row].quantity
            measure = model.pantry[indexPath.row].units
            if let date = model.pantry[indexPath.row].expiration{
                let format = DateFormatter()
                format.dateFormat = "MM/dd/yyyy"
                let now = format.string(from: date)
                cell.expire.text = "Expires: " + now
            }
            else{
                cell.expire.text = "No expiration!"
            }
            
        }
        else{
            name = model.filteredPantry[indexPath.row].name!
            amount = model.filteredPantry[indexPath.row].quantity
            measure = model.filteredPantry[indexPath.row].units
            if let date = model.filteredPantry[indexPath.row].expiration{
                let format = DateFormatter()
                format.dateFormat = "MM/dd/yyyy"
                let now = format.string(from: date)
                cell.expire.text = "Expires: " + now
            }
            else{
                cell.expire.text = "No expiration!"
            }
            
        }
        var measureStr = measure!
        if amount != 1.0{
            measureStr += "s"
        }

 
        cell.name.text = name
        cell.amount.text = String(amount) + " " + measureStr
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        if isSearching{
            selected = model.filteredPantry[row]
        }
        else{
            selected = model.pantry[row]
        }
        performSegue(withIdentifier: "viewDataMore", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? viewData{
            destination.ingrendients = self.selected!
            destination.model = self.model
        }
    }

    
}

