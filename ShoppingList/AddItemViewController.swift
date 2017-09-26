//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-04.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let productList = Product.generateSampleList()
    var productDataSource = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial data source not filtered
        self.productDataSource = self.productList
        
        self.searchBar.delegate = self
    }
    
    // MARK: Actions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.productDataSource = self.productList
        }
        else {
            self.productDataSource = self.productList.filter({ (p) -> Bool in
                
                return p.name.lowercased().contains(searchText.lowercased())
            })
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if productDataSource.count > 0 {
            return productDataSource.count
        }
        else {
            self.productDataSource.append(Product(name: "new|item", section: "no|sect"))
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "add-item-cell") as? AddItemTableViewCell else {
            print("Error dequeing cell")
            return UITableViewCell()
        }
        
        let product = productDataSource[indexPath.row]
        
        // If no item was found, allow user to add the item
        if product.name == "new|item" && product.section == "no|sect" {
            
            cell.nameLabel.text = "No item found. Click here to add it."
            cell.isInListLabel.isHidden = true
        }
        else {
        
            cell.nameLabel.text = "\(product.name) (\(product.section))"
            
            if product.addedToList {
                self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.isInListLabel.isHidden = false
            }
            else {
                cell.isInListLabel.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Mark product as selected in the full list
        let selectedProduct = self.productDataSource[indexPath.row]
        
        if let cell = self.tableView.cellForRow(at: indexPath) as? AddItemTableViewCell {
            
            cell.isInListLabel.isHidden = false
            
            for p in self.productList {
                
                if p.name == selectedProduct.name {
                    p.addedToList = true
                    break
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        // Mark product as unselected in the full list
        let selectedProduct = self.productDataSource[indexPath.row]
        
        if let cell = self.tableView.cellForRow(at: indexPath) as? AddItemTableViewCell {
            
            cell.isInListLabel.isHidden = true
            
            for p in self.productList {
                
                if p.name == selectedProduct.name {
                    p.addedToList = false
                    break
                }
            }
        }
    }
}
