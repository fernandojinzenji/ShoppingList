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
    
    class func list(completion: @escaping ([Product]) -> ()) {
    
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
    
    class func generateSampleList() -> [Product] {
        
        var list = [Product]()
        
        list.append(Product(name: "butter", section: "dairy"))
        list.append(Product(name: "iogurt", section: "dairy"))
        list.append(Product(name: "milk", section: "dairy"))
        
        list.append(Product(name: "beef", section: "meat"))
        list.append(Product(name: "chicken", section: "meat"))
        list.append(Product(name: "fish", section: "meat"))
        
        list.append(Product(name: "soap", section: "housekeep"))
        list.append(Product(name: "detergent", section: "housekeep"))
        list.append(Product(name: "trash bag", section: "housekeep"))
        
        list.append(Product(name: "juice", section: "drink"))
        list.append(Product(name: "soft drink", section: "drink"))
        list.append(Product(name: "water", section: "drink"))
        
        list.append(Product(name: "ice cream", section: "frozen"))
        list.append(Product(name: "smores", section: "frozen"))
        list.append(Product(name: "frozen food", section: "frozen"))
        
        return list
    }
    
    func saveToFirebase() {
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
    
}
