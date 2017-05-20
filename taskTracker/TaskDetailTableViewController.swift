//
//  TaskDetailTableViewController.swift
//  taskTracker
//
//  Created by George Knight on 9/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TaskDetailTableViewController: UITableViewController {
    
    var task : TaskInfo!
    var geoCoder = CLGeocoder()
    
    @IBOutlet weak var taskNumber: UITextField!
    @IBOutlet weak var taskDueDate: UITextField!
    @IBOutlet weak var taskLocation: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    
    @IBAction func mapDirections(_ sender: UIBarButtonItem) {
        // Sets up geocoder to look at the location content in the task location textfield
        // geocoder then converts the Location information a latitude and longitude coordinate
        geoCoder.geocodeAddressString(taskLocation.text!) {
            placemarks, error in
            
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            // instruct for the generated latitude and longitude to be printed in the output console (This information will be further used in later releases of the app
            print("Lat: \(lat!), Lon: \(lon!)")
            
            
            let regionDistance: CLLocationDistance = 1000;// sets the map dispay span
            let coordinates = CLLocationCoordinate2DMake(lat!, lon!) //Establishes the Lat and lon as coordinates
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue (mkCoordinateSpan: regionSpan.span)]
            // instructs the map to open apple maps and place the coordinates on the map in order to provide directions from the users current location
            let taskplaceMark = MKPlacemark(coordinate: coordinates)
            let mapTask = MKMapItem(placemark: taskplaceMark)
            mapTask.name = "My Task"
            mapTask.openInMaps(launchOptions: options)
        }
        
        
    }
    
    
    // places details information regarding the selected task into the appropriate textfields
    override func viewWillAppear(_ animated: Bool){
        
        if task != nil{
            taskNumber.text = "Task Number: \(String(describing: task!.TaskNumber!))"
            taskDueDate.text = "Due Date: \(String(describing: task!.DueDate!))"
            taskLocation.text = "Location: \(String(describing: task!.Suburb!))"
            taskDescription.text = "Task Description: \(String(describing: task!.TDescript!))"
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
            // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mapVC: MapViewController = segue.destination as! MapViewController
        
        mapVC.addressString = taskLocation.text!
    }
    */
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
}
