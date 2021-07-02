//
//  ViewController.swift
//  milongainventory
//
//  Created by Jose Alvarez on 7/8/20.
//  Copyright © 2020 josealvarezavina. All rights reserved.
//

import UIKit
import Firebase


    class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate {
        
        @IBOutlet weak var quantityField: UITextField!
        
        @IBOutlet weak var locationField: UITextField!
        
        @IBOutlet weak var nameField: UITextField!
        
        @IBOutlet weak var pickerView: UIPickerView!
        @IBOutlet weak var SubmitButton: UIButton!
        @IBOutlet weak var ViewInventoryButton: UIButton!
        @IBOutlet weak var MilongaLogo: UIImageView!
        
        var pickerData = [["beef", "chicken", "chorizo", "sweetpotato", "humita", "hamandcheese", "eggandbacon", "mushroom", "potato" , "roastedveggie", "spinach", "fugazeta", "apple", "tuna","chimichurri"],
               ["Maleva", "Copetin", "2oz", "9oz"],
               ["SSF", "Napa"],
               ["In", "Out", "Throwaway"]]
        
        let foods = ["Beef", "Chicken", "Chorizo", "Sweet Potato", "Humita", "Ham and Cheese", "Egg & Bacon", "Mushroom", "Potato" , "Roasted Veggie", "Spinach", ]
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
            return 4
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            return pickerData[component][row]
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
            return pickerData[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {

        }
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
                var label = UILabel()
                if let v = view {
                    label = v as! UILabel
                }
                label.font = UIFont (name: "Helvetica Neue", size: 10)
                label.text =  pickerData[component][row]
                label.textAlignment = .center
                return label
            }
        
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            title = "Inventory Manager"
            self.SubmitButton.layer.cornerRadius = 10
            self.ViewInventoryButton.layer.cornerRadius = 10
            self.MilongaLogo.layer.cornerRadius = 20
            self.MilongaLogo.layer.borderColor = UIColor.black.cgColor
            self.MilongaLogo.layer.borderWidth = 4
            
            quantityField.delegate = self
            nameField.delegate = self
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            quantityField.resignFirstResponder()
            nameField.resignFirstResponder()
            return true
        }
        
        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func set_data(){
            let quantity = quantityField.text!
            var startingQuan = 0
            var workingQuans = 0
            var submittedAt = Date()
            let textfieldInt: Int? = Int(quantity)
            
            let selectedFlavor = pickerView.selectedRow(inComponent: 0)
            let selectedSize = pickerView.selectedRow(inComponent: 1)
            let selectedLocation = pickerView.selectedRow(inComponent: 2)
            let selectedType = pickerView.selectedRow(inComponent: 3)
            
            let flavor = pickerData[0][selectedFlavor]
            let size = pickerData[1][selectedSize]
            let location = pickerData[2][selectedLocation]
            let type =  pickerData[3][selectedType]
            let person = nameField.text!
            let full_flavor = flavor + size
            
            let db = Firestore.firestore()


            let quanRef = db.collection("empanadas").document(full_flavor)
            quanRef.getDocument { (document, error) in
            if let document = document{

            if document.exists {
                startingQuan = (document.get("quantity") as? Int)!
            }
            }

            if type == "In"
            {
                workingQuans = textfieldInt! + startingQuan
                let textfieldInt = workingQuans

                let docRef = db.collection("empanadas").document(full_flavor)
                docRef.setData(["quantity":textfieldInt], merge: true)
                let newDoc = db.collection("transactions")
                newDoc.addDocument(data: ["Product": full_flavor,"Quantity": quantity, "Size": size, "Location": location,"Employee": person])
            }
            else
            {
                workingQuans = startingQuan - textfieldInt!
                let textfieldInt = workingQuans
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.dateStyle = .long
                
                let dateTime = formatter.string(from: submittedAt)
                
                let docRef = db.collection("empanadas").document(full_flavor)
                docRef.setData(["quantity":textfieldInt], merge: true)
                let newDoc = db.collection("transactions")
                newDoc.addDocument(data: ["Product": full_flavor,"Quantity": quantity, "Size": size, "Location": location,"Employee": person,"Date": dateTime])
            }

            }
        }
        
        @IBAction func submitTapped(_ sender: Any) {
            set_data()


            
            
        
        
    }


}
