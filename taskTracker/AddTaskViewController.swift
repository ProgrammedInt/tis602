//
//  AddTaskViewController.swift
//  taskTracker
//
//  Created by George Knight on 6/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskNumberField: UITextField!
    @IBOutlet weak var suburbLocationField: UITextField!
    @IBOutlet weak var duedateField: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    
    
    
    
    var userStorage: FIRStorageReference!
    var databaseRef: FIRDatabaseReference!
    var user = FIRAuth.auth()?.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let storage = FIRStorage.storage().reference(forURL: "gs://tasktracker-98cfd.appspot.com")
        
        databaseRef = FIRDatabase.database().reference()
        userStorage = FIRStorage.storage().reference()
    }
    @IBAction func saveTaskPressed(_ sender: UIButton) {
        
        post()
    }
    
    func post(){
    
        let post : [String : AnyObject] =
        ["Task Number" : self.taskNumberField.text! as AnyObject,
        "Suburb Location" : self.suburbLocationField.text! as AnyObject,
            "Due Date" : self.duedateField.text! as AnyObject,
            "Task Description" : self.taskDescription.text! as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
    databaseRef.child("users").child((user?.uid)!).child("Task").childByAutoId().setValue(post)
     
    }

    @IBAction func logoutAction(_ sender: UIButton) {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            do {
                
                try FIRAuth.auth()?.signOut()
                self.performSegue(withIdentifier: "taskSeguelogin", sender: self)
                
            } catch let error as NSError {
                print(error.localizedDescription)
    }
        }}

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
