//
//  ViewController.swift
//  milongainventory
//
//  Created by Jose Alvarez on 7/8/20.
//  Copyright © 2020 josealvarezavina. All rights reserved.
//

import UIKit
import Firebase

    class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
        @IBOutlet weak var quantityField: UITextField!
        
        @IBOutlet weak var locationField: UITextField!
        
        @IBOutlet weak var typeField: UITextField!
        
        @IBOutlet weak var pickerView: UIPickerView!
        
        var pickerData = [["Beef", "Chicken", "Chorizo", "Sweet Potato", "Humita", "Ham and Cheese", "Egg & Bacon", "Mushroom", "Potato" , "Roasted Veggie", "Spinach"],
               ["Maleva", "Copetin", "1oz", "10oz"],
               ["South San Francisco", "Napa"],
               ["Raul", "Ricardo", "Jose", "Alex"]]
        
        let foods = ["Beef", "Chicken", "Chorizo", "Sweet Potato", "Humita", "Ham and Cheese", "Egg & Bacon", "Mushroom", "Potato" , "Roasted Veggie", "Spinach" ]
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
            return 4
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            return foods[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
            return foods.count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            locationField.text = foods[row]
        }
        
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func submitTapped(_ sender: Any) {
            let quantity = quantityField.text!
            var startingQuan = 0
            let textfieldInt: Int? = Int(quantity)
            let choice = foods[pickerView.selectedRow(inComponent: 0)]
            if choice == "Beef"{
                let db = Firestore.firestore()
                
                let quanRef = db.collection("empanadas").document("beefMaleva")
                quanRef.getDocument { (document, error) in
                    if let document = document{
                                                      
                        if document.exists {
                            startingQuan = (document.get("quantity") as? Int)!
                        }
                }
                    let textfieldInt = textfieldInt! + startingQuan
                let docRef = db.collection("empanadas").document("beefMaleva")
                docRef.setData(["quantity":textfieldInt], merge: true)
                
            }
        }
        
        
    }

}
