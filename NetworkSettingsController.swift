//
//  NetworkSettingsController.swift
//  comblie
//
//  Created by Cal on 11/10/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class NetworkSettingsController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var grayBarHeight: NSLayoutConstraint!
    
    var facebook : Bool!
    var twitter : Bool!
    var instagram : Bool!
    var tumblr : Bool!
    var vine : Bool!
    
    var userPrefs : NSUserDefaults!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.facebook = true
        self.twitter = false
        self.instagram = false
        self.tumblr = true
        self.vine = true
    
        self.userPrefs = NSUserDefaults.standardUserDefaults()
        
        self.grayBarHeight.constant = CGFloat(0.5)
        
        checkAuthentication()
        initializeSwitches()
    }

    //MARK: Actions
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Other
    
    func checkAuthentication() {
        for item in self.stackView.subviews {
            var connectButton : UIButton!
            var connectionLabel : UILabel!
            var connectSwitch : UISwitch!
            
            if item.tag != 1 {
                let networkName = item.restorationIdentifier
                //Network names : facebook, twitter, etc...
                print(networkName)
                for innerItem in item.subviews {
                    if innerItem.tag == 5 {
                        connectionLabel = innerItem as! UILabel
                        
                        if networkName == nil {
                            connectionLabel.alpha = CGFloat(0)
                        } else {
                            connectionLabel.alpha = CGFloat(1)
                        }
                    } else if innerItem.tag == 3 {
                        connectButton = innerItem as! UIButton
                        
                        if networkName == nil {
                            connectButton.alpha = CGFloat(1)
                        } else {
                            connectButton.alpha = CGFloat(0)
                        }
                    } else if innerItem.tag == 0 {
                        connectSwitch = innerItem as! UISwitch
                        connectSwitch.addTarget(self, action: "TriggerNetworks:", forControlEvents: .ValueChanged)
                        // Sets the UserPrefs on UISwitch
                        connectSwitch.on = userPrefs.boolForKey(connectSwitch.restorationIdentifier!)
                        
                        if networkName == nil {
                            connectSwitch.alpha = CGFloat(0)
                        } else {
                            connectSwitch.alpha = CGFloat(1)
                            
                        }
                    }
                }
            }
        }
    }
    
    func initializeSwitches() {
        //Sets separator thickness and scales switches
        for item in self.stackView.subviews {
            if item.tag == 1 {
                item.constraints.first?.constant = CGFloat(0.5)
            } else {
                for innerItem in item.subviews {
                    var switchButton : UISwitch!
                    
                    //Iterates through the elements
                    if innerItem.isKindOfClass(UISwitch) {
                        switchButton = innerItem as! UISwitch
                        switchButton.transform = CGAffineTransformMakeScale(0.75, 0.75)
                        switchButton.addTarget(self, action: "stateChanged:", forControlEvents: UIControlEvents.ValueChanged)
                        stateChanged(switchButton)
                    }
                    
                }
            }
        }
    }
    
    func stateChanged(switchButton : UISwitch) {
        var connectionLabel : UILabel!
        var connectionNetwork : UILabel!
        
        for item in (switchButton.superview?.subviews)! {
            if item.tag == 5 {
                connectionLabel = item as! UILabel
            } else if item.tag == 2 {
                connectionNetwork = item as! UILabel
            }
        }
        
        if switchButton.on {
            connectionLabel.text = "Connected"
            connectionNetwork.textColor = UIColor.blackColor()
        } else {
            connectionLabel.text = "Disconnected"
            connectionNetwork.textColor = UIColor.lightGrayColor()
        }
    }
    
    func TriggerNetworks(switchButton : UISwitch) {
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
