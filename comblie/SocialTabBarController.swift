//
//  testViewController.swift
//  comblie
//
//  Created by Cal on 10/13/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class SocialTabBarController: UIViewController {
    
    var VC : UITabBarController!
    
    @IBOutlet weak var customTabBar: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var feedsButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonsContainer: UIStackView!
    
    var buttons : [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VC = self.storyboard!.instantiateViewControllerWithIdentifier("SocialTabPage") as! UITabBarController
        self.addChildViewController(VC)
        self.view.addSubview(VC.view)
        self.view.bringSubviewToFront(customTabBar)
        
        // Style tab bar
        buttons = buttonsContainer.subviews as! [UIButton]
        initializeConstraints()
        initializeTabBarButtons()
    }

    func chooseTab(sender: UIButton) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        switch sender {
            case profileButton:
                VC.selectedIndex = 0
                showSelectedButton(sender, index: 0)
                break
            case notificationsButton:
                VC.selectedIndex = 1
                showSelectedButton(sender, index: 1)
                break
            case feedsButton:
                VC.selectedIndex = 2
                showSelectedButton(sender, index: 2)
                FeedRequestManager.sharedInstance.getFeedRequest()
                break
            case messagesButton:
                VC.selectedIndex = 3
                showSelectedButton(sender, index: 3)
                break
            case settingsButton:
                VC.selectedIndex = 4
                showSelectedButton(sender, index: 4)
                
                break
            default:
                break
        }
    }
    
    func showSelectedButton(button: UIButton, index: Int) {
        for (buttonIndex, element) in buttons.enumerate() {
            if (buttonIndex == index) {
                element.selected = true
            } else {
                element.selected = false
            }
        }
    }
    
    func initializeConstraints() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        if screenWidth <= 320 {
            print("iPhone4 and iPhone5")
            tabBarHeight.constant = 40
        } else if screenWidth == 375 {
            print("iPhone6")
            tabBarHeight.constant = 45
        } else {
            print("iPhone6S")
            tabBarHeight.constant = 50
        }
    }
    
    func initializeTabBarButtons() {
        
        // Adds button to listener
        profileButton.addTarget(self, action: "chooseTab:", forControlEvents: UIControlEvents.TouchUpInside)
        notificationsButton.addTarget(self, action: "chooseTab:", forControlEvents: UIControlEvents.TouchUpInside)
        feedsButton.addTarget(self, action: "chooseTab:", forControlEvents: UIControlEvents.TouchUpInside)
        messagesButton.addTarget(self, action: "chooseTab:", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButton.addTarget(self, action: "chooseTab:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Sets the selected images
        settingsButton.setBackgroundImage(UIImage(named: "settingsdark"), forState: .Selected)
        profileButton.setBackgroundImage(UIImage(named: "profiledark"), forState: .Selected)
        notificationsButton.setBackgroundImage(UIImage(named: "notificationsdark"), forState: .Selected)
        feedsButton.setBackgroundImage(UIImage(named: "feedsdark"), forState: .Selected)
        messagesButton.setBackgroundImage(UIImage(named: "messagesdark"), forState: .Selected)
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
