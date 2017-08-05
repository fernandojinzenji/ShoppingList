//
//  SignInViewController.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-04.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: Actions
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        
        Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!) { (opError) in
            
            let alert = UIAlertController(title: "E-mail sent", message: "Please, check your e-mail to see how to reset your password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (opUser, opError) in
            
            if opError != nil {
            
                let alert = UIAlertController(title: "Ooops", message: opError!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                
                UserDefaults.standard.set(opUser?.email!, forKey: "loggedEmail")
                self.performSegue(withIdentifier: "signin-main-segue", sender: self)
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
