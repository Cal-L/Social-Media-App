//
//  PushNotificationsController.swift
//  comblie
//
//  Created by Cal on 11/4/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class PushNotificationsController: UIViewController {

    @IBOutlet weak var graybarHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    var userPrefs : NSUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userPrefs = NSUserDefaults.standardUserDefaults()
        
        // Do any additional setup after loading the view.
        self.graybarHeight.constant = CGFloat(0.5)
        
        //Sets separator thickness and scales switches
        for item in self.stackView.subviews {
            if item.tag == 1 {
                item.constraints.first?.constant = CGFloat(0.5)
            } else {
                for innerItem in item.subviews {
                    if innerItem.isKindOfClass(UISwitch) {
                        let switchButton = innerItem as! UISwitch
                        switchButton.on = userPrefs.boolForKey(switchButton.restorationIdentifier!)
                        switchButton.addTarget(self, action: "TriggerNotifications:", forControlEvents: UIControlEvents.ValueChanged)
                        switchButton.transform = CGAffineTransformMakeScale(0.75, 0.75)
                    }
                }
            }
        }
    }

    
    //MARK: Actions
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func TriggerNotifications(switchButton : UISwitch) {
        userPrefs.setBool(switchButton.on, forKey: switchButton.restorationIdentifier!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
