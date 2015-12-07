//
//  PrivacyPolicyController.swift
//  comblie
//
//  Created by Cal on 11/4/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class PrivacyPolicyController: UIViewController {
    
    @IBOutlet weak var grayBarHeight: NSLayoutConstraint!
    @IBOutlet weak var policyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.grayBarHeight.constant = CGFloat(0.5)
        
        self.policyText.contentInset = UIEdgeInsetsMake(3, 0, 5, 0)
    }
    
    override func viewDidLayoutSubviews() {
        self.policyText.setContentOffset(CGPointMake(0, -3), animated: false)
    }
    
    //MARK: Action
    
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
