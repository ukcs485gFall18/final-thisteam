//
//  ViewController.swift
//  Recipe
//
//  Created by Jones, Caitlin on 10/11/18.
//  Copyright © 2018 Jones, Caitlin All rights reserved.
//Resourses: 
//

import UIKit
import CoreData

class SuperViewController: UIViewController {
    
    public var myPantryModel = pantryModel()
    let container: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    lazy var moc: NSManagedObjectContext = container.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myPantryModel.load()
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPantry"{
            if let destination = segue.destination as? pantryViewController{
                destination.model = self.myPantryModel
            }
        }
        else if segue.identifier == "viewPantry"{
            if let destination = segue.destination as? viewPantryContentsController{
                destination.model = self.myPantryModel
            }
        }
    }
    
}


