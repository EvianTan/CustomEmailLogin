//
//  ViewController.swift
//  CustomEmailLogin
//
//  Created by Evian tan  on 27/10/2017.
//  Copyright © 2017 Evian tan . All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        // Flip the boolean
        isSignIn = !isSignIn
        
        // Check the bool and set the button and labels
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // TODO: Do some sorm validation on the email and password
        
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            // Chech if it is sign in or register
            if isSignIn {
                // Sign in the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    
                    // Check that user isn't nil
                    if let u = user {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: check error and show message
                    }
                }
                
            }
            else {
                // Register the user with Firebase
                
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    
                    // Check that user isn't nil
                    if let u = user {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: check error and show message
                    }
                }
            }
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

