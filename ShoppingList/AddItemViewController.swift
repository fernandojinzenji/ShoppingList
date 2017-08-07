//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-04.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let productList = Product.generateSampleList()
    var productDataSource = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial data source not filtered
        self.productDataSource = self.productList
    }
    
    // MARK: Actions

    @IBAction func filterChanged(_ sender: UITextField) {
        
        if (sender.text?.isEmpty)! {
            
            self.productDataSource = self.productList
        }
        else {
            
            self.productDataSource = self.productList.filter({ (p) -> Bool in
                return p.name.contains(sender.text!)
            })
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "add-item-cell") else {
            print("Error dequeing cell")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "\(productDataSource[indexPath.row].name) (\(productDataSource[indexPath.row].section))"
        
        return cell
    }
}
