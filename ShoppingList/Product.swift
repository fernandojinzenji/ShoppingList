//
//  Product.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-05.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import Foundation

class Product {
    
    var name: String
    var section: String
    var addedToList = false
    
    init(name: String, section: String) {
        
        self.name = name
        self.section = section
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
    
}
