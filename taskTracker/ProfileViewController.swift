//
//  ProfileViewController.swift
//  taskTracker
//
//  Created by George Knight on 5/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!

    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    // initiating the Firebase DataBase
    var databaseRef: FIRDatabaseReference!
    var refHandle: UInt!
 
     // initiating the Firebase Storage
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       databaseRef = FIRDatabase.database().reference()
        /*refHandle = databaseRef.observe(FIRDataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
            
            print(dataDict)
        })
        */
        
        // Telling system where to find user information in Firebase and to take a snapshot of this information and display it in the appropriate text fields in the app.
        let userID = FIRAuth.auth()?.currentUser?.uid
        databaseRef.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let email = value?["Email"] as? String
            let firstName = value?["First Name"] as? String
            let surName = value?["Surname"] as? String
            let phoneNo = value?["Phone No"] as? String
            
            // Instructing the snapshot of information to be displayed in the appropriate textfields
            
            self.firstnameTextField.text = firstName
            self.surnameTextField.text = surName
            self.phoneTextField.text = phoneNo
            self.emailTextField.text = email
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logOutAction(_ sender: UIButton) {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            do {
                
                try FIRAuth.auth()?.signOut()
                self.performSegue(withIdentifier: "profileSeguelogin", sender: self)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

}
