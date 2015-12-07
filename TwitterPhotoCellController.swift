//
//  TwitterPhotoCellController.swift
//  comblie
//
//  Created by Cal on 10/24/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TwitterPhotoCellController: UITableViewCell {
    
    var parent : UITableViewController!
    
    
    @IBOutlet weak var postBackgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    @IBOutlet weak var lineSeparator: UIView!
    
    var VC : CommentsController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.postBackgroundImage.image = UIImage(named: "vinebackground")
        
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
        configureText()
        lineHeight.constant = CGFloat(0.5)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        lineSeparator.backgroundColor = UIColor.whiteColor()
        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        lineSeparator.backgroundColor = UIColor.whiteColor()
    }
    
    //MARK: Actions
    
    @IBAction func enlarge(sender: UIButton) {
        VC = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("Comments") as! CommentsController
        VC.postHeight = self.contentView.frame.height
        self.window?.rootViewController?.presentViewController(VC, animated: true, completion: nil)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    func configureText() {
        var user = "Smith "
        var userMutableString = NSMutableAttributedString()
        userMutableString = NSMutableAttributedString(string: user, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Roman",
            size: 10.0)!])
        
        var sectionOne = "retweeted "
        var sectionOneMutableString = NSMutableAttributedString()
        sectionOneMutableString = NSMutableAttributedString(string: sectionOne, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Lt",
            size: 10.0)!])
        
        var author = "Johnny"
        var authorMutableString = NSMutableAttributedString()
        authorMutableString = NSMutableAttributedString(string: author, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Roman",
            size: 10.0)!])
        
        var sectionTwo = "'s post on "
        var sectionTwoMutableString = NSMutableAttributedString()
        sectionTwoMutableString = NSMutableAttributedString(string: sectionTwo, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Lt",
            size: 10.0)!])
        
        var network = "Twitter"
        var networkMutableString = NSMutableAttributedString()
        networkMutableString = NSMutableAttributedString(string: network, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Roman",
            size: 10.0)!])
        
        
        userMutableString.appendAttributedString(sectionOneMutableString)
        userMutableString.appendAttributedString(authorMutableString)
        userMutableString.appendAttributedString(sectionTwoMutableString)
        userMutableString.appendAttributedString(networkMutableString)
        statusText.attributedText = userMutableString
    }
    
}
