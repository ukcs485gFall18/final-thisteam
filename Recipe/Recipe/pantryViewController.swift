//
//  pantryViewController.swift
//  Recipe
//
//  Created by Ryan Gaines on 10/28/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//https://stackoverflow.com/questions/40484182/ios-swift-3-uidatepicker
//https://stackoverflow.com/questions/43148864/how-to-get-a-push-notification-at-a-set-time-swift-3
//https://stackoverflow.com/questions/46206920/swift-making-a-uipickerview-go-round-as-a-loop


import Foundation
import UIKit

class pantryViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var pantryQuantity:UIPickerView!
    @IBOutlet weak var pantryItem:UITextField!
    
    // https://en.wikipedia.org/wiki/Cooking_weights_and_measures
    private var pantryData:[[String]] = [[String]]()
    
    @IBOutlet weak var saveExpire: UISwitch!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var expireDate: UIDatePicker!
    let loopingMargin = 50
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
        self.pantryQuantity.selectRow(50, inComponent: 0, animated: false)
        self.pantryQuantity.selectRow(50, inComponent: 2, animated: false)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 3{
            return 150.0
        }
        return 39.0

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 || component == 2{
            return pantryData[component].count * loopingMargin
        }
        return pantryData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 || component == 2{
            return pantryData[component][row % pantryData[component].count]
        }
        return pantryData[component][row]
    }


    func setupPicks(){
        self.pantryQuantity.delegate = self
        self.pantryQuantity.dataSource = self
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 || component == 2{
            let current = row % pantryData[component].count
            pantryQuantity.selectRow(loopingMargin/2 * pantryData[component].count + current, inComponent: component, animated: false)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        let name = pantryItem.text
        let first = pantryData[0][pantryQuantity.selectedRow(inComponent: 0) % 100]
        let third = pantryData[2][pantryQuantity.selectedRow(inComponent: 2) % 100]
        let quantity = pantryData[3][pantryQuantity.selectedRow(inComponent: 3)]
        let amount = Double(first)! + Double(third)!/100
        let cal = Calendar.current.dateComponents([.year,.month, .day], from: self.expireDate.date)
        if (saveExpire.isOn){
            //SAVE TO MODEL WITH DATE
        }
        else{
            //SAVE TO MODEL WITHOUT DATE
        }
        let alert = UIAlertController(title: "Save Status", message: "Successfully saved \(name!) to the pantry", preferredStyle: .alert)
        let doneAction: UIAlertAction = UIAlertAction(title:"Okay", style: .default){ (alertAction) -> Void in self.dismiss(animated: true, completion: nil)
            self.reset()
        }
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    func reset(){
        self.pantryItem.text = ""
        self.pantryQuantity.selectRow(50, inComponent: 0, animated: true)
        self.pantryQuantity.selectRow(50, inComponent: 2, animated: true)
        self.pantryQuantity.selectRow(0, inComponent: 3, animated: true)
        self.expireDate.setDate(NSDate() as Date, animated: true)
        self.saveExpire.isOn = true
    }
    
    
    
}
