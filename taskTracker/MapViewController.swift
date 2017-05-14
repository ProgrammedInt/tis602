//
//  MapViewController.swift
//  taskTracker
//
//  Created by George Knight on 13/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts
import ContactsUI

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var taskMap: MKMapView!
    
    
    var addressString : String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = addressString
        self.taskMap.delegate = self
        
        //taskMap.setCenter(taskMap.userLocation.coordinate, animated: true)

        // Do any additional setup after loading the view.
        
        func showAddress(f:CNPostalAddress){
            let addressString: String = "\(f.city)"
            
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressString, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                
                let friendPlacemark:CLPlacemark = placemarks!.first!
                let mapRegion: MKCoordinateRegion = MKCoordinateRegion(
                    center: friendPlacemark.location!.coordinate,
                    span: MKCoordinateSpanMake(0.2, 0.2))
                self.taskMap.setRegion(mapRegion, animated: true)
                
                let mapPlacemark: MKPlacemark = MKPlacemark(placemark: friendPlacemark)
                self.taskMap.addAnnotation(mapPlacemark)
                
                
                } as! CLGeocodeCompletionHandler)

                
        
        /*
        let taskSuburb = receivedString as String
            
        CLGeocoder().geocodeAddressString(receivedString, completionHandler: {(placeMark, error) in
            
            let taskLocation = placeMark![0].location?.coordinate
            self.taskMap.addAnnotation(self.locationLabel.text as! MKAnnotation)
    }
   )
 */
   
 
    func didReceiveMemoryWarning() {
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

        func showAddress(f:CNPostalAddress){
            let addressString: String = "\(f.subLocality)"
            
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressString, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                
                let friendPlacemark:CLPlacemark = placemarks!.first!
                let mapRegion: MKCoordinateRegion = MKCoordinateRegion(
                    center: friendPlacemark.location!.coordinate,
                    span: MKCoordinateSpanMake(0.2, 0.2))
                self.taskMap.setRegion(mapRegion, animated: true)
                
                let mapPlacemark: MKPlacemark = MKPlacemark(placemark: friendPlacemark)
                self.taskMap.addAnnotation(mapPlacemark)
                
  
} as! CLGeocodeCompletionHandler)

}
    }}
}
