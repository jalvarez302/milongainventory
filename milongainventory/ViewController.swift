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
        
        var pickerData = [["Beef", "Chicken", "Chorizo", "Sweet Potato", "Humita", "Ham and Cheese", "Egg & Bacon", "Mushroom", "Potato" , "Roasted Veggie", "Spinach", "Fugazeta"],
               ["Maleva", "Copetin", "1oz", "10oz"],
               ["SSF", "Napa"],
               ["In", "Out", "Throwaway"]]
        
        let foods = ["Beef", "Chicken", "Chorizo", "Sweet Potato", "Humita", "Ham and Cheese", "Egg & Bacon", "Mushroom", "Potato" , "Roasted Veggie", "Spinach" ]
        
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
        
        @IBAction func submitTapped(_ sender: Any) {
            let quantity = quantityField.text!
            var startingQuan = 0
            var workingQuans = 0
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


            
            if flavor == "Beef"{
                let db = Firestore.firestore()
                
                if size == "Maleva"
                {
                    let quanRef = db.collection("empanadas").document("beefMaleva")
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
                            
                            let docRef = db.collection("empanadas").document("beefMaleva")
                            docRef.setData(["quantity":textfieldInt], merge: true)
                            let newDoc = db.collection("transactions")
                            newDoc.addDocument(data: ["Product": "Beef Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                        }
                        else
                        {
                            workingQuans = startingQuan - textfieldInt!
                            let textfieldInt = workingQuans
                            
                            let docRef = db.collection("empanadas").document("beefMaleva")
                            docRef.setData(["quantity":textfieldInt], merge: true)
                            let newDoc = db.collection("transactions")
                            newDoc.addDocument(data: ["Product": "Beef Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                        }

                    }
                }
                else{
                    let quanRef = db.collection("empanadas").document("beefCopetin")
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
                                               
                        let docRef = db.collection("empanadas").document("beefCopetin")
                        docRef.setData(["quantity":textfieldInt], merge: true)
                        let newDoc = db.collection("transactions")
                        newDoc.addDocument(data: ["Product": "Beef Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                    }
                    else
                    {
                        workingQuans = startingQuan - textfieldInt!
                        let textfieldInt = workingQuans
                                               
                        let docRef = db.collection("empanadas").document("beefCopetin")
                        docRef.setData(["quantity":textfieldInt], merge: true)
                        let newDoc = db.collection("transactions")
                        newDoc.addDocument(data: ["Product": "Beef Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                    }
                    }
                }
                
            }
            if flavor == "Chicken"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("chikenMaleva")
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
                                                          
                                    let docRef = db.collection("empanadas").document("chickenMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Chicken Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                   workingQuans = startingQuan - textfieldInt!
                                   let textfieldInt = workingQuans
                                                          
                                   let docRef = db.collection("empanadas").document("chickenMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Chicken Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("chickenCopetin")
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
                                                          
                                    let docRef = db.collection("empanadas").document("chickenCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Chicken Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("chickenCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Chicken Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Chorizo"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("chorizoMaleva")
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
                                                          
                                    let docRef = db.collection("empanadas").document("chorizoMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Chorizo Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("chorizoMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Chorizo Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("chorizoCopetin")
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
                                                          
                                   let docRef = db.collection("empanadas").document("chorizoCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Chorizo Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("chorizoCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Chorizo Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            
            if flavor == "Egg & Bacon"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("eggandbaconMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("eggandbaconMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Egg and Bacon Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("eggandbaconMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Egg and Bacon Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("eggandbaconCopetin")
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
                                                          
                                   let docRef = db.collection("empanadas").document("eggandbaconCopetin")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Egg and Bacon Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("eggandbaconCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Egg and Bacon Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Ham and Cheese"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("hamandcheeseMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("hamandcheeseMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Ham and Cheese Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                   let docRef = db.collection("empanadas").document("hamandcheeseMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Ham and Cheese Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("hamandcheeseCopetin")
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
                                                          
                                   let docRef = db.collection("empanadas").document("hamandcheeseCopetin")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Ham and Cheese Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("hamandcheeseCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Ham and Cheese Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Humita"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("humitaMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("humitaMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Humita Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("humitaMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Humita Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("humitaCopetin")
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
                                                          
                                   let docRef = db.collection("empanadas").document("humitaCopetin")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Humita Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("humitaCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Humita Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Mushroom"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("mushroomMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("mushroomMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Mushroom Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("mushroomMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Mushroom Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("mushroomCopetin")
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
                                                          
                                   let docRef = db.collection("empanadas").document("mushroomCopetin")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Mushroom Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("mushroomCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Mushroom Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Potato"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("potatoMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("potatoMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Potato Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("potatoMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Potato Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("potatoCopetin")
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
                                                          
                                   let docRef = db.collection("empanadas").document("potatoCopetin")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Potato Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("potatoCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Potato Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Roasted Veggie"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("roastedveggieMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("roastedveggieMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Roasted Veggie Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("roastedveggieMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Roasted Veggie Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("roastedveggieCopetin")
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
                                                          
                                    let docRef = db.collection("empanadas").document("roastedveggieCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Roasted Veggie Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("roastedveggieCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Roasted Veggie Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Spinach"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("spinachMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("spinachMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Spinach Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                   let docRef = db.collection("empanadas").document("spinachMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Spinach Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("spinachCopetin")
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
                                                          
                                    let docRef = db.collection("empanadas").document("spinachCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Spinach Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("spinachCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Spinach Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Sweet Potato"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("sweetpotatoMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("sweetpotatoMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Sweet Potato Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("sweetpotatoMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Sweet Potato Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("sweetpotatoCopetin")
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
                                                          
                                    let docRef = db.collection("empanadas").document("sweetpotatoCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Sweet Potato Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("sweetpotatoCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Sweet Potato Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            if flavor == "Fugazeta"{
                           let db = Firestore.firestore()
                           
                           if size == "Maleva"
                           {
                               let quanRef = db.collection("empanadas").document("fugazetaMaleva")
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
                                                          
                                   let docRef = db.collection("empanadas").document("fugazetaMaleva")
                                   docRef.setData(["quantity":textfieldInt], merge: true)
                                   let newDoc = db.collection("transactions")
                                   newDoc.addDocument(data: ["Product": "Fugazeta Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("fugazetaMaleva")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Fugazeta Maleva","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           else{
                               let quanRef = db.collection("empanadas").document("fugazetaCopetin")
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
                                                          
                                    let docRef = db.collection("empanadas").document("fugazetaCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Fugazeta Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               else
                               {
                                    workingQuans = startingQuan - textfieldInt!
                                    let textfieldInt = workingQuans
                                                          
                                    let docRef = db.collection("empanadas").document("fugazetaCopetin")
                                    docRef.setData(["quantity":textfieldInt], merge: true)
                                    let newDoc = db.collection("transactions")
                                    newDoc.addDocument(data: ["Product": "Fugazeta Copetin","Quantity": quantity, "Size": size, "Location": location,"Employee": person])
                               }
                               }
                           }
                           
                       }
            
        }
        
        
    }


