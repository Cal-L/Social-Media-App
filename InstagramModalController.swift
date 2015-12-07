//
//  InstagramModalController.swift
//  comblie
//
//  Created by Cal on 11/5/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class InstagramModalController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    
    var postHeight : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
        self.lineHeight.constant = CGFloat(0.5)
    }
    
    //MARK: Actions
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openComments(sender: UIButton) {
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("Comments") as! CommentsController
        //This gives it an error of presenting an active controller
        //self.addChildViewController(VC)
        VC.postHeight = self.postHeight
        self.presentViewController(VC, animated: true, completion: nil)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
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
