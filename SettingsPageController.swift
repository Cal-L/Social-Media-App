//
//  SettingsPageController.swift
//  comblie
//
//  Created by Cal on 11/3/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class SettingsPageController: UIViewController {

    @IBOutlet weak var settingsContent: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsContainer: UIView!
    @IBOutlet weak var grayBarHeight: NSLayoutConstraint!
    @IBOutlet weak var chatSwitch: UISwitch!
    @IBOutlet weak var refreshSwitch: UISwitch!
    
    var userPrefs : NSUserDefaults!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.grayBarHeight.constant = CGFloat(0.5)
        
        userPrefs = NSUserDefaults.standardUserDefaults()
        self.refreshSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        self.refreshSwitch.addTarget(self, action: "TriggerSettings:", forControlEvents: .ValueChanged)
        self.chatSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        self.chatSwitch.addTarget(self, action: "TriggerSettings:", forControlEvents: .ValueChanged)
        self.refreshSwitch.on = userPrefs.boolForKey(self.refreshSwitch.restorationIdentifier!)
        self.chatSwitch.on = userPrefs.boolForKey(self.chatSwitch.restorationIdentifier!)
        
        for stack in self.settingsContent.subviews {
            if stack.isKindOfClass(UIStackView) {
                for item in stack.subviews {
                    if item.tag == 1 {
                        item.constraints.first?.constant = CGFloat(0.5)
                    } else {
                        for innerItem in item.subviews {
                            if innerItem.isKindOfClass(UIButton) {
                                let button = innerItem as! UIButton
                                button.addTarget(self, action: "openSubSettings:", forControlEvents: UIControlEvents.TouchUpInside)
                            }
                        }
                    }
                }
            }
        }
        
    }

    override func viewDidAppear(animated: Bool) {
        self.scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, self.settingsContent.frame.height)
    }
    
    // MARK: Actions
    
    func openSubSettings(sender: UIButton){
        let controllerName = sender.restorationIdentifier
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier(controllerName!)
        self.presentViewController(VC!, animated: true, completion: nil)
    }
    
    func TriggerSettings(switchButton : UISwitch) {
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
