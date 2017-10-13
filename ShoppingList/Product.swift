//
//  Product.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-05.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Product {
    
    var name: String
    var section: String
    var addedToList = false
    
    init(name: String, section: String) {
        
        self.name = name
        self.section = section
    }
    
    class func getProductList(completion: @escaping ([Product]) -> ()) {
    
        var list = [Product]()
        
        if let currentListID = UserDefaults.standard.value(forKey: "listID") as? String {
            
            let ref = Database.database().reference(withPath: "products").child(currentListID)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String : Any] {
                    
                    for key in dictionary.keys {
                        list.append(Product(name: key, section: ""))
                    }
                    
                    completion(list.sorted( by: { $0.name < $1.name }))
                }
            })
        }

    }
    
    class func getShoppingList(completion: @escaping ([Product]) -> ()) {
        
        var list = [Product]()
        
        if let currentListID = UserDefaults.standard.value(forKey: "listID") as? String {
            
            let ref = Database.database().reference(withPath: "lists").child(currentListID)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String : Any] {
                    
                    for key in dictionary.keys {
                        list.append(Product(name: key, section: ""))
                    }
                    
                    completion(list.sorted( by: { $0.name < $1.name }))
                }
            })
        }
        
    }
    
    class func clearShoppingList() {
        if let currentListID = UserDefaults.standard.value(forKey: "listID") as? String {
            
            let ref = Database.database().reference(withPath: "lists").child(currentListID)
            ref.removeValue()
        }
    }
    
    func saveProduct() {
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        var ref = DatabaseReference()
        
        // Save first item in the list
        if let currentListID = UserDefaults.standard.value(forKey: "listID") as? String {
            
            ref = Database.database().reference(withPath: "products").child(currentListID)
        }
        else
        {
            ref = Database.database().reference(withPath: "products").childByAutoId()
            UserDefaults.standard.set(ref.key, forKey: "listID")
        }
        
        let newRef = ref.child(name)
        newRef.setValue(userID)
    }
    
    func removeProduct() {
        // Get ListID
        if let currentListID = UserDefaults.standard.value(forKey: "listID") as? String {
            
            Database.database().reference(withPath: "products").child(currentListID).child(name).removeValue()
        }
    }
    
    func addInList() {
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        // Get ListID
        if let currentListID = UserDefaults.standard.value(forKey: "listID") as? String {
            
            let ref = Database.database().reference(withPath: "lists").child(currentListID)
            let newRef = ref.child(name)
            newRef.setValue(userID)
        }
    }
    
    func removeFromList() {
        // Get ListID
        if let currentListID = UserDefaults.standard.value(forKey: "listID") as? String {
            
            Database.database().reference(withPath: "lists").child(currentListID).child(name).removeValue()
        }
    }
    
}
