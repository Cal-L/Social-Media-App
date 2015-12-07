//
//  ComposeViewController.swift
//  comblie
//
//  Created by Cal on 12/1/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var topSeparatorLine: NSLayoutConstraint!
    @IBOutlet weak var middleSeparatorLine: NSLayoutConstraint!
    @IBOutlet weak var bottomSeparatorLine: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topSeparatorLine.constant = CGFloat(0.5)
        middleSeparatorLine.constant = CGFloat(0.5)
        bottomSeparatorLine.constant = CGFloat(0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIButton) {
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
