//
//  LoginViewController.swift
//  taskTracker
//
//  Created by George Knight on 4/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        // Checks to see if there is an entry in either the username or password fields.
        if emailTextField.text != "" && passwordTextField.text != ""
        {   // tells system where to check in firebase for user details
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
            if user != nil //Check if there is a user in firbase
            {   // if user was not nil (in the database) segues to userprofile page
                self.performSegue(withIdentifier: "loginSegueprofile", sender: self)
                }
                else
            {
                if let myError = error?.localizedDescription
                {   // if user not found an alert message will prompt the user to create a new sign in
                    self.userNotFoundAlert()
               
                    self.performSegue(withIdentifier: "loginSeguesignup", sender: self)
                    print(myError)// Prints out error if no user found
                }
                else
                {
                    print("ERROR")
                    self.performSegue(withIdentifier: "loginSeguesignup", sender: self)
                }
                }
        })
        
        
    }
        else
        {   // tells system where to check in firebase for user details
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                if user != nil // Check if user has been created successfully (not nil)
                {
                    self.performSegue(withIdentifier: "loginSegueprofile", sender: self)
                }
                else
                {
                    if let myError = error?.localizedDescription
                    {
                        print(myError) // Prints error message if no user found
                        
                    }
                    else
                    {
                        print("ERROR")
                    }
                }
                
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // setting the Password and Text Field delegates to user operated
        
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return (true)
    }
    // function for the alert message if user not found in firebase database
    func userNotFoundAlert (){
        let alertController = UIAlertController(title: "User Not Found", message: "Please Sign-Up", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    

