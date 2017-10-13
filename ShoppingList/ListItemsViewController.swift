//
//  ListItemsViewController.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-04.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import UIKit

class ListItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddItemViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyListMessage: UILabel!
    var shoppingList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        DispatchQueue.main.async {
            
            Product.getShoppingList(completion: { (list) in
                self.shoppingList = list
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            })
        }
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "add-items-segue" {
            
            let destinationViewController = segue.destination as! AddItemViewController
            destinationViewController.delegate = self
            destinationViewController.currentShoppingList = shoppingList
            destinationViewController.navigationController?.isNavigationBarHidden = true
        }
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        emptyListMessage.isHidden = (shoppingList.count > 0)
        tableView.isHidden = (shoppingList.count == 0)
        
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopping-item-cell")!
        
        let product = shoppingList[indexPath.row]
        
        cell.textLabel?.text = product.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let item = shoppingList[indexPath.row]
            item.removeFromList()
            
            shoppingList.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "Check!"
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "👍", handler: { (action, indexPath) in
            
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        })
        
        deleteButton.backgroundColor = UIColor.green
        
        return [deleteButton]
    }
    
    // MARK: AddItemViewControllerDelegate

    func didFinishedAddItems(selectedProducts: [Product]) {
        
        Product.clearShoppingList()
        
        for p in selectedProducts {
            p.addInList()
        }
        
        shoppingList = selectedProducts
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }

}
