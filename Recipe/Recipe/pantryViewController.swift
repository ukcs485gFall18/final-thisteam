//
//  pantryViewController.swift
//  Recipe
//
//  Created by Ryan Gaines on 10/28/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//https://stackoverflow.com/questions/40484182/ios-swift-3-uidatepicker
//https://stackoverflow.com/questions/43148864/how-to-get-a-push-notification-at-a-set-time-swift-3


import Foundation
import UIKit

class pantryViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var pantryQuantity:UIPickerView!
    @IBOutlet weak var pantryItem:UITextField!
    
    // https://en.wikipedia.org/wiki/Cooking_weights_and_measures
    private var pantryData:[[String]] = [[String]]()
    
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var expireDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        expireDate.datePickerMode = UIDatePicker.Mode.date
        let arr = Array(0...99)
        var arrStr:[String] = [String]()
        for i in arr{
            arrStr.append(String(i))
        }
        self.pantryData = [arrStr,
                           ["."],
                           arrStr,
                           ["Gallon", "Liter", "Quart", "Pint",
                            "Cup", "Fluid Ounce", "Tablespoon", "Teaspoon"]
            ]
        self.setupPicks()
        
    }
    
    @IBAction func updateLabel(_ sender: UIDatePicker) {
        let cal = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let year = cal.year, let month = cal.month, let day = cal.day{
            expirationLabel.text = "Expiration Date:\t\t\t\t\(month)/\(day)/\(year)"

        }
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pantryData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pantryData[component][row]
    }


    func setupPicks(){
        self.pantryQuantity.delegate = self
        self.pantryQuantity.dataSource = self
        
    }
    
    func prepareForNotfication(){
        
    }
    
    
    
}
