//
//  CookbookTableViewCell.swift
//  Recipe
//
//  Created by Jones, Caitlin on 10/25/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import UIKit

class CookbookTableViewCell: UITableViewCell {
    
    //PROPERTIES
    @IBOutlet weak var CellLabel: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
