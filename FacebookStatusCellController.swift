//
//  FacebookStatusCellController.swift
//  comblie
//
//  Created by Cal on 10/30/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class FacebookStatusCellController: UITableViewCell {

    @IBOutlet weak var postAuthor: UILabel!
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var lineSeparator: UIView!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    
    var parent : UITableViewController!
    var VC : CommentsController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage
        .frame.height/2)
        self.lineHeight.constant = CGFloat(0.5)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.lineSeparator.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        self.lineSeparator.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        
        self.postAuthor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "openProfile"))
    }
    
    // MARK: Actions
    
    func openProfile() {
        let profileView = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("PublicProfile")
        self.parent.parentViewController!.navigationController?.pushViewController(profileView!, animated: true)
    }
    
    @IBAction func enlarge(sender: UIButton) {
        VC = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("Comments") as! CommentsController
        VC.postHeight = self.contentView.frame.height
        self.window?.rootViewController?.presentViewController(VC, animated: true, completion: nil)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default

    }
}
