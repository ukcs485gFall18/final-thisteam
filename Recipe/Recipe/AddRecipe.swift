//
//  AddRecipe.swift
//  Recipe
//
//  Created by Jones, Caitlin on 12/11/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation
import UIKit



class AddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var ChangeImage: UIButton!
    @IBOutlet weak var NameEdit: UITextField!
    @IBOutlet weak var PrepTimeEdit: UITextField!
    @IBOutlet weak var CookTimeEdit: UITextField!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var TempEdit: UITextField!
    @IBOutlet weak var IngredientTable: UITableView!
    @IBOutlet weak var InstructionTable: UITableView!
    
    @IBOutlet weak var AddIngredient: UIButton!
    
    var instructions:[String] = [String]()
    var ingredients:[Ingredient] = [Ingredient]()
    
    var imagePicker = UIImagePickerController()

    //https://stackoverflow.com/questions/24180954/how-to-hide-keyboard-in-swift-on-pressing-return-key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func AddIngredient(_ sender: Any) {
        //Popup a box to add ingredient
        let alertController = UIAlertController(title: "Add Ingredients", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Ingredient Name..."
        })

        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Measure..."
            textField.keyboardType = UIKeyboardType.decimalPad
            
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {alert->Void in
                let newIngred = Ingredient(context: moc)
                newIngred.name = alertController.textFields![0].text!
                newIngred.quantity = Double(alertController.textFields![1].text!)!
                newIngred.expiration = nil
                newIngred.inPantry = false
                newIngred.units = alertController.textFields![2].text!
                self.ingredients.append(newIngred)
                self.IngredientTable.reloadData()
            
        })
        
        //https://stackoverflow.com/questions/30596851/how-do-i-validate-textfields-in-an-uialertcontroller
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Amount..."
            saveAction.isEnabled = false
            
        })
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alertController.textFields![1], queue: OperationQueue.main){(notification)-> Void in
            if let _ = Double(alertController.textFields![1].text!){
                saveAction.isEnabled = true
            }
            else{
                saveAction.isEnabled = false
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        saveAction.isEnabled = false
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var AddInstruction: UIButton!
    @IBAction func AddInstruction(_ sender: Any) {
        //Popup a box to add Instruction
        let alertController = UIAlertController(title: "Add Instructions!", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter step here..."
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {alert->Void in
            let curr = alertController.textFields![0] as UITextField
            self.instructions.append(curr.text!)
            self.InstructionTable.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //https://stackoverflow.com/questions/25510081/how-to-allow-user-to-pick-the-image-with-swift
    @IBAction func addImage(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }

    //https://stackoverflow.com/questions/44465904/photopicker-discovery-error-error-domain-pluginkit-code-13
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.RecipeImage.contentMode = .scaleAspectFit
            self.RecipeImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    var nameFromSegue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TempEdit.isHidden = true
        TempLabel.isHidden = true
        
        
        if(nameFromSegue != ""){
            NameEdit.text = nameFromSegue
        }
        self.CookTimeEdit.delegate = self
        self.NameEdit.delegate = self
        self.PrepTimeEdit.delegate = self
        self.TempEdit.delegate = self
        

        self.IngredientTable.delegate = self
        self.IngredientTable.dataSource = self
        self.IngredientTable.reloadData()
        self.IngredientTable.accessibilityIdentifier = "ingred"
        self.IngredientTable.rowHeight = 50.0
        self.InstructionTable.rowHeight = 50.0
        self.InstructionTable.delegate = self
        self.InstructionTable.dataSource = self
        self.InstructionTable.reloadData()
        self.InstructionTable.accessibilityIdentifier = "instruct"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.accessibilityIdentifier == "ingred"{
            return self.ingredients.count
        }
        else{
            return self.instructions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.accessibilityIdentifier == "ingred"{
            let cell = self.IngredientTable.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
            cell.Amount.text = String(self.ingredients[indexPath.row].quantity) + " " + self.ingredients[indexPath.row].units!
            cell.IngredientLabel.text = self.ingredients[indexPath.row].name!
            return cell
        }
        else{
            let cell = self.InstructionTable.dequeueReusableCell(withIdentifier: "InstructionCell") as! InstructionCell
            cell.StepText.text = String(indexPath.row + 1) + ")" + " " + self.instructions[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView.accessibilityIdentifier == "ingred"{
            self.IngredientTable.deselectRow(at: indexPath, animated: true)
            let row = indexPath.row
            let alert = UIAlertController(title: "Delete Ingredient?", message: "Do you want to delete \(self.ingredients[row].name!)?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete", style: .default, handler:{ a->Void in
                self.ingredients.remove(at: row)
                self.IngredientTable.reloadData()
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            self.InstructionTable.deselectRow(at: indexPath, animated: true)
            let row = indexPath.row
            let alert = UIAlertController(title: "Delete Instruction?", message: "Do you want to delete \(self.instructions[row])?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete", style: .default, handler:{ a->Void in
                self.instructions.remove(at: row)
                self.InstructionTable.reloadData()
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }

    
}
