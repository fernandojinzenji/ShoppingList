//
//  ViewController.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-03.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Auth.auth().signIn(withEmail: "fernandoj@me.com", password: "nananda78") { (opUser, opError) in
            
            if opError != nil {
                print ("auth error")
            }
            else {
                print ("auth ok")
                let ref = Database.database().reference(withPath: "childnode")
                ref.setValue("test")
            }
        }
    }
}

