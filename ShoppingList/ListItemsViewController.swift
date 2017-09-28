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
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "add-items-segue" {
            
            let destinationViewController = segue.destination as! AddItemViewController
            destinationViewController.delegate = self
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
    
    
    
    // MARK: AddItemViewControllerDelegate

    func didFinishedAddItems(selectedProducts: [Product]) {
        
        shoppingList = selectedProducts
        tableView.reloadData()
        
    }

}
