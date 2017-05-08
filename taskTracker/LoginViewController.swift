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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        // Checks to see if there is an entry in either the username or password fields.
        if emailTextField.text != "" && passwordTextField.text != ""
        {
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
            if user != nil //Check if there is a user in firbase
            {
                self.performSegue(withIdentifier: "loginSegueprofile", sender: self)
                }
                else
            {
                if let myError = error?.localizedDescription
                {
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
        {
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

        // Do any additional setup after loading the view.
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

}
