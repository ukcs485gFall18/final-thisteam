//
//  pantryViewController.swift
//  Recipe
//
//  Created by Ryan Gaines on 10/28/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//https://stackoverflow.com/questions/40484182/ios-swift-3-uidatepicker
//

import Foundation
import UIKit

class pantryViewController : UIViewController{
    
    @IBOutlet weak var pantryQuantity:UITextField!
    @IBOutlet weak var pantryMeasuringAmount:UITextField!
    @IBOutlet weak var pantryItem:UITextField!
    
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var expireDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        expireDate.datePickerMode = UIDatePicker.Mode.date
        
    }
    
    @IBAction func updateLabel(_ sender: UIDatePicker) {
        let cal = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let year = cal.year, let month = cal.month, let day = cal.day{
            expirationLabel.text = "Expiration Date:\t\t\t\t\(month)/\(day)/\(year)"
        }

    }
    
    
    
}
