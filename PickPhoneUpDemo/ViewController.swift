//
//  ViewController.swift
//  PickPhoneUpDemo
//
//  Created by Todd Krokowski on 8/12/16.
//  Copyright © 2016 GreyDayProductions. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    lazy var motionManager = CMMotionManager()
    var switchedLabel = false
    
    @IBOutlet weak var descriptiveLabel: UILabel!
    
    func setLabelText(labelText: String, direction: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            self.descriptiveLabel.text = labelText
            self.switchedLabel = direction
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if motionManager.accelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1;
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: {
                data, error in
                if let acceleration = data?.acceleration {
                    if self.switchedLabel {
                        if abs(acceleration.y) < 0.2 {
                            self.setLabelText("On the table...", direction: !self.switchedLabel)
                        }
                    } else {
                        if abs(acceleration.y) > 0.8 {
                            self.setLabelText("Picked up...", direction: !self.switchedLabel)
                        }
                    }
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

