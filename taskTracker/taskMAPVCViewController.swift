//
//  taskMAPVCViewController.swift
//  taskTracker
//
//  Created by George Knight on 13/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation


class taskMAPVCViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var ref : FIRDatabaseReference?
    var refHandle : UInt!
    var taskList = [TaskInfo]()
    var currentUser = FIRAuth.auth()?.currentUser
    
    let locationManager = CLLocationManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        // Do any additional setup after loading the view.
        
        mapTask()
        self.map.delegate = self
        map.setCenter(map.userLocation.coordinate, animated: true)
        
        for i in 0 ... taskList.count - 1 {
            let mappedTask = taskList[i]
            
            CLGeocoder().geocodeAddressString(mappedTask.Suburb!, completionHandler: { (placeMark, error) in
                let taskLocation = placeMark![0].location?.coordinate
                self.map.addAnnotation(TaskAnnotation(taskID: Int(i), task: mappedTask, coordinate: taskLocation!))
            })
            
        }
        
    }

    func mapTask(){
        
        refHandle = ref?.child("users").child((currentUser?.uid)!).child("Task").observe(.childAdded, with: { (snapshot) in
            
            if let mapDictionary = snapshot.value as? [String:AnyObject]
            {
                print(mapDictionary)
                
                let mapTask = TaskInfo()
                mapTask.DueDate = (mapDictionary["Due Date"] as! String)
                mapTask.Suburb = (mapDictionary["Suburb Location"] as! String)
                mapTask.TaskNumber = (mapDictionary["Task Number"] as! String)
                mapTask.TDescript = (mapDictionary["Task Description"] as! String)
            }
            
            
            
        } )
        
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
