//
//  PublicProfileController.swift
//  comblie
//
//  Created by Cal on 11/24/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class PublicProfileController : UIViewController {
    
    var previousHeaderColor : UIColor!
    var navBar : UINavigationBar!
    var triggeredNetwork : String!
    //var previousStatusBar : UIStatusBarStyle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar = self.navigationController?.navigationBar
        // Do any additional setup after loading the view.
        self.previousHeaderColor = self.navBar.barTintColor
        print(previousHeaderColor)
        self.navigationItem.title = "SomeProfile"
        self.navBar.titleTextAttributes = [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Bold",
            size: 15.5)!]
        //self.navBar.backItem?.title = "";
        self.navBar.barTintColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        var backButton: UIButton = UIButton(frame: CGRectMake(0, 0, 12, 22))
        backButton.setBackgroundImage(UIImage(named: "backArrow.png"), forState: .Normal)
        var barBackButtonItem: UIBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: "goBack", forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = barBackButtonItem
        self.navigationItem.hidesBackButton = true
        
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("TwitterProfile")
        self.addChildViewController(VC!)
        self.view.addSubview(VC!.view)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    func goBack() {
        self.navBar.barTintColor = previousHeaderColor;
        if self.navigationController?.viewControllers.indexOf(self)! == 1 {
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        }
        self.navigationController?.popViewControllerAnimated(true)
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
