//
//  SignUpViewController.swift
//  taskTracker
//
//  Created by George Knight on 4/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import AVFoundation

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confpasswordTextField: UITextField!
    @IBOutlet weak var newUserButton: UIButton!
    
    
    var userStorage: FIRStorageReference!
    var databaseRef: FIRDatabaseReference!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // tells system URL in firebase for storage of data
        let storage = FIRStorage.storage().reference(forURL: "gs://tasktracker-98cfd.appspot.com")
        //Access storage/data base in Firebase and creates a child called Users and puts all login details under this child
        databaseRef = FIRDatabase.database().reference()
        userStorage = storage.child("Users")
    }

    // Selecting a image the user can identify with
    @IBAction func selectimagePressed(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            self.userImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        // Guard Statement checks if there are entries in req fields befor proceeding
        guard firstnameTextField.text != "", surnameTextField.text != "", phoneTextField.text != "", emailTextField.text != "", passwordTextField.text != "", confpasswordTextField.text != "" else {return}
        // ensures password has been correctly entered twice
        if passwordTextField.text == confpasswordTextField.text {
            //Granting system permission to create the user in Firebase
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let user = user {
                    // User has the ability to adjust/over write their profile details
                    let changeRequest = FIRAuth.auth()!.currentUser!.profileChangeRequest()
                    changeRequest.displayName = self.firstnameTextField.text!
                    changeRequest.commitChanges(completion: nil)
                    
                    let imageRef = self.userStorage.child("\(user.uid).jpg")
                    
                    let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.5)
                    
                    let uploadTask = imageRef.put(data!, metadata: nil, completion: { (metadata, err) in
                        if err != nil {
                            print(err!.localizedDescription)
                            
                        }
                        
                        imageRef.downloadURL(completion: { (url, er) in
                            if er != nil {
                                print(er!.localizedDescription)
                            }
                            
                            if let url = url {
                                // Creating a new tier of child to be placed into Firebase.  These children are under each user
                                let userInfo: [String: Any] = ["uid" : user.uid,
                                                            
                                            "First Name" : self.firstnameTextField.text!,
                                            "Surname" : self.surnameTextField.text!,
                                            "Phone No" : self.phoneTextField.text!,
                                            "Email" : self.emailTextField.text!,
                                            "urlToImage" : url.absoluteString]
                                // telling firbase to save above details under each users unique UID
                                self.databaseRef.child("users").child(user.uid).setValue(userInfo)
                                
                                self.performSegue(withIdentifier: "signupSegueprofile", sender: self)
                                
                                
                                
                            }
                            
                        })
                        
                    })
                    
                    uploadTask.resume()
                    
                }
                
            })
            
        }
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
