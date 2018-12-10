//
//  InstructionStepViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 11/4/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//https://stackoverflow.com/questions/28468906/how-do-i-change-the-text-of-a-button-when-it-is-clicked-swift
//https://stackoverflow.com/questions/18753864/ios-7-back-button-symbol

import Foundation
import UIKit

class InstructionStepViewController: UIViewController {
    
    
    @IBAction func Prev(_ sender: UIButton) {
        StepCountLabel.text = "Step 1"
        
    }
    
    @IBAction func Next(_ sender: UIButton) {
        StepCountLabel.text = "Step 2"
        
    }
    
    @IBOutlet weak var StepCountLabel: UILabel!
    @IBOutlet weak var StepTextView: UITextView!
    
    //needed for Segue
    var StepText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
