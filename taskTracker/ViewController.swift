//
//  ViewController.swift
//  taskTracker
//
//  Created by George Knight on 4/5/17.
//  Copyright © 2017 George Knight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var trackerView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animateTask()
        animateTracker()
    }

    func animateTask(){
        
        UIView.animate(withDuration: 1) { 
            self.taskView.alpha = 1
        }
        
    }
    func animateTracker(){
        
        UIView.animate(withDuration: 3, delay: 2, animations: {
            self.trackerView.alpha = 1
        }) { finished in
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
}

