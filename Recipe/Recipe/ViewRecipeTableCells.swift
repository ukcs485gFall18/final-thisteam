//
//  ViewRecipeTableCells.swift
//  Recipe
//
//  Created by Jones, Caitlin on 12/9/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell{
    
    @IBOutlet weak var IngredientLabel: UILabel!
    @IBOutlet weak var Amount: UILabel!
    @IBOutlet weak var InPantryImg: UIImageView!
    
}

class InstructionCell: UITableViewCell{
    
    @IBOutlet weak var StepText: UILabel!
    @IBOutlet weak var Num: UILabel!
    
}
