//
//  viewData.swift
//  Recipe
//
//  Created by Ryan Gaines on 12/9/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation
import UIKit

class viewData: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    let loopingMargin = 50    
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var date:UILabel!
    @IBOutlet weak var measure:UILabel!
    @IBOutlet weak var amount:UILabel!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var updateMeasure:UIPickerView!
    var pantryData:[[String]] = [[String()]]
    var model:pantryModel = pantryModel()
    var ingrendients:Ingredient? = nil
    
    @IBOutlet weak var onSwitch: UISwitch!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateMeasure.delegate = self
        self.updateMeasure.dataSource = self
        datePicker.datePickerMode = UIDatePicker.Mode.date
        name.text = ingrendients!.name
        amount.text = String(ingrendients!.quantity)
        measure.text = convertToStr(measure: ingrendients?.units).capitalized
        if let d = ingrendients?.expirationDate{
            let format = DateFormatter()
            format.dateFormat = "MM/dd/yyyy"
            let now = format.string(from: d)
            date.text = now
            datePicker.date = d
        }
        else{
            date.text = "N/A"
            datePicker.isEnabled = false
            onSwitch.isOn = false
        }
        let arr = Array(0...99)
        var arrStr:[String] = [String]()
        for i in arr{
            arrStr.append(String(i))
        }
        pantryData = [arrStr, ["."], arrStr]
        let startVal = ingrendients?.quantity
        let start = floor(startVal!)
        let end = Int((startVal!-start)*100)
        self.updateMeasure.selectRow(Int(start), inComponent: 0, animated: false)
        self.updateMeasure.selectRow(end, inComponent: 2, animated: false)
    
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
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
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 39.0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 || component == 2{
            let current = row % pantryData[component].count
            updateMeasure.selectRow(loopingMargin/2 * pantryData[component].count + current, inComponent: component, animated: false)
        }
    }
    @IBAction func updater(_ sender: Any) {
        if onSwitch.isOn{
            datePicker.isEnabled = true
        }
        else{
            datePicker.isEnabled = false
        }
    }
    
    @IBAction func deleteRecord(_ sender: Any){
        model.deletItem(Item: ingrendients!)
        let alert = UIAlertController(title: "Delete Status", message: "Successfully deleted \(ingrendients!.name) from the pantry", preferredStyle: .alert)
        let okay = UIAlertAction(title:"Okay", style: .default,handler: { (alertAction) -> Void in      self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okay)
        self.present(alert, animated: true)
    }
    
    @IBAction func updateRecord(_ sender: Any){
        model.updateItem(item: ingrendients!)
        let alert = UIAlertController(title: "Save Status", message: "Successfully updated \(ingrendients!.name) to the pantry", preferredStyle: .alert)
        let okay = UIAlertAction(title:"Okay", style: .default,handler: { (alertAction) -> Void in      self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
})
        alert.addAction(okay)
        self.present(alert, animated: true)
    }
    

}
