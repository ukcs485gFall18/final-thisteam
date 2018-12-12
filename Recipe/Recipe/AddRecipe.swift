//
//  AddRecipe.swift
//  Recipe
//
//  Created by Jones, Caitlin on 12/11/18.
//  Copyright © 2018 Jones, Caitlin N. All rights reserved.
//

import Foundation
import UIKit



class AddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var ChangeImage: UIButton!
    @IBOutlet weak var NameEdit: UITextField!
    @IBOutlet weak var PrepTimeEdit: UITextField!
    @IBOutlet weak var CookTimeEdit: UITextField!
    @IBOutlet weak var TempEdit: UITextField!
    @IBOutlet weak var IngredientTable: UITableView!
    @IBOutlet weak var InstructionTable: UITableView!
    
    @IBOutlet weak var AddIngredient: UIButton!
    
    var instructions:[String] = [String]()
    var ingredients:[Ingredient] = [Ingredient]()
    
    var imagePicker = UIImagePickerController()

    
    @IBAction func AddIngredient(_ sender: Any) {
        //Popup a box to add ingredient
        let alertController = UIAlertController(title: "Add Ingredients", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Ingredient Name..."
        })

        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Measure..."
            
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {alert->Void in
            if let val = Double(alertController.textFields![1].text!){
                let newIngred = Ingredient(context: moc)
            }
            
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
        
        if(nameFromSegue != ""){
            NameEdit.text = nameFromSegue
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)

        self.IngredientTable.delegate = self
        self.IngredientTable.dataSource = self
        self.IngredientTable.reloadData()
        self.IngredientTable.accessibilityIdentifier = "ingred"
        
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
            cell.Amount.text = String(self.ingredients[indexPath.row].quantity) + self.ingredients[indexPath.row].units!
            cell.IngredientLabel.text = self.ingredients[indexPath.row].name!
            return cell
        }
        else{
            let cell = self.InstructionTable.dequeueReusableCell(withIdentifier: "InstructionCell") as! InstructionCell
            cell.StepText.text = String(indexPath.row + 1) + ")" + " " + self.instructions[indexPath.row]
            return cell
        }
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
