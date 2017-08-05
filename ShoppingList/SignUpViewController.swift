//
//  SignUpViewController.swift
//  ShoppingList
//
//  Created by Fernando Jinzenji on 2017-08-04.
//  Copyright © 2017 Fernando Jinzenji. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var privacyPolicyCheckbox: UIView!
    
    var privacyPolicyChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        
        self.privacyPolicyCheckbox.isUserInteractionEnabled = true
        self.privacyPolicyCheckbox.layer.cornerRadius = 4.0
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    // MARK: Actions
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        // Local validations
        if !self.privacyPolicyChecked {
            
            let alert = UIAlertController(title: "Privacy Policy", message: "You need to check our Privacy Policy to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.emailTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty || self.confirmPasswordTextField.text!.isEmpty {
            
            let alert = UIAlertController(title: "Required fields", message: "Sorry, but all fields are required", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.passwordTextField.text! != self.confirmPasswordTextField.text! {
            
            let alert = UIAlertController(title: "Passwords do not match", message: "Sorry, but your passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Save to firebase
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (opUser, opError) in
            
            if opError != nil {
                
                let alert = UIAlertController(title: "Ooops", message: opError!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                
                UserDefaults.standard.set(opUser?.email!, forKey: "loggedEmail")
                self.performSegue(withIdentifier: "signup-main-segue", sender: self)
            }
        }
    }
    
    @IBAction func checkboxTapped(_ sender: UITapGestureRecognizer) {
        
        if self.privacyPolicyChecked == false {
            
            self.privacyPolicyChecked = true
            self.privacyPolicyCheckbox.backgroundColor = UIColor.gray
        }
        else {
            
            self.privacyPolicyChecked = false
            self.privacyPolicyCheckbox.backgroundColor = UIColor.white
        }
    }
    
    // UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
