//
//  InvenViewController.swift
//  milongainventory
//
//  Created by Jose Alvarez on 8/9/20.
//  Copyright © 2020 josealvarezavina. All rights reserved.
//

import UIKit
import Firebase



class InvenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct Product{
        let productName: String
        let productQuantity: Int
        let productSize: String
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var Products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inventory Display"

        getDatabaseRecords()
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
//     tableView.delegate = self

   //     tableView.register(InvenViewCell.self, forCellReuseIdentifier: "InvenViewCell")
        
  //      self.tableView.reloadData()
        
        tableView.rowHeight = 70
        tableView.layer.cornerRadius = 10
        

        // remove separators for empty cells
 //       tableView.tableFooterView = UIView()
        // remove separators from cells
 //       tableView.separatorStyle = .none
 //       self.tableView.reloadData()

    }
    
    func getDatabaseRecords() {
        
        let db = Firestore.firestore()
        
        Products = []  //  Empty the array
        db.collection("empanadas").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    let newEntry = Product(
                        productName: document.documentID ,
                        productQuantity: data["quantity"] as! Int,
                        productSize: data["size"] as! String)
                    self.Products.append(newEntry)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Products.count)
        return Products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostInvenCell", for: indexPath) as! InvenViewCell
    
        let Product = Products[indexPath.row]
        
        print(Product.productName, Product.productSize,Product.productQuantity )
        
        cell.nameLabel.text = Product.productName
        cell.sizeLabel.text = Product.productSize
        cell.quantityLabel.text = String(Product.productQuantity)
        
        return cell
    }
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

