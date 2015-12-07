//
//  TumblrPhotoModalController.swift
//  comblie
//
//  Created by Cal on 11/19/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TumblrPhotoModalController: UIViewController {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var reblogButton: UIButton!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
        self.lineHeight.constant = CGFloat(0.5)
    }
    
    
    // MARK: Actions
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
