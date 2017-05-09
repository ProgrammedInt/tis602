//
//  TaskListViewController.swift
//  taskTracker
//
//  Created by George Knight on 4/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
   
    var ref : FIRDatabaseReference?
    var refHandle: UInt!
    var taskList = [TaskInfo]()
    var currentUser = FIRAuth.auth()?.currentUser
    
    
    // Set Up TableView
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        // Do any additional setup after loading the view.
            
        self.myTableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
        ref = FIRDatabase.database().reference()
        fetchTask()
            
    }
    
    func fetchTask(){
        refHandle = ref?.child("users").child((currentUser?.uid)!).child("Task").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                print(dictionary)
                
                
                let task = TaskInfo()
                task.DueDate = (dictionary["Due Date"] as! String)
                task.Suburb = (dictionary["Suburb Location"] as! String)
                task.TaskNumber = (dictionary["Task Number"] as! String)
                task.TDescript = (dictionary["Task Description"] as! String)


                self.taskList.append(task)
                self.myTableView.reloadData()
                
            }
            
        })
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return taskList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tasklistCell")

        cell.textLabel?.text = "Due Date: \(self.taskList[indexPath.row].DueDate!)"
        cell.detailTextLabel!.text = "Task Location: \(self.taskList[indexPath.row].Suburb!)"
        
        
        // Set Cell Contects
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueTaskDetails", sender: self.taskList[indexPath.row])
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueTaskDetails"{
            (segue.destination as! TaskDetailTableViewController).task = (sender as! TaskInfo)
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }

    
    
        
    
    

    
    

}
}
