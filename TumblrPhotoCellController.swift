//
//  TumblrPhotoCellController.swift
//  comblie
//
//  Created by Cal on 10/24/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TumblrPhotoCellController: UITableViewCell {
    
    
    @IBOutlet weak var postBackgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    @IBOutlet weak var lineSeparator: UIView!
    
    var VC : TumblrPhotoModalController!
    
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
        VC = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("TumblrModal") as! TumblrPhotoModalController
        //For keeping the opacity
        VC.providesPresentationContextTransitionStyle = true
        VC.definesPresentationContext = true
        VC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.window?.rootViewController?.presentViewController(VC, animated: true, completion: setModal)
    }
    
    func setModal() {
        VC.thumbnailImage.image = self.postBackgroundImage.image
        VC.profileImage.image = self.profileImage.image
        VC.postText.text = self.postText.text
        VC.statusText.attributedText = self.statusText.attributedText
        VC.reblogButton.setBackgroundImage(UIImage(named: "tumblrRepost"), forState: .Normal)
        VC.likeButton.setBackgroundImage(UIImage(named: "tumblrHeart"), forState: .Normal)
    }
    
    
    //MARK: Other
    
    func configureText() {
        var user = "officialbeckham "
        var userMutableString = NSMutableAttributedString()
        userMutableString = NSMutableAttributedString(string: user, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Roman",
            size: 10.0)!])
        
        var sectionOne = "reblogged "
        var sectionOneMutableString = NSMutableAttributedString()
        sectionOneMutableString = NSMutableAttributedString(string: sectionOne, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Lt",
            size: 10.0)!])
        
        var author = "ilovepotato"
        var authorMutableString = NSMutableAttributedString()
        authorMutableString = NSMutableAttributedString(string: author, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Roman",
            size: 10.0)!])
        
        var sectionTwo = "'s post on "
        var sectionTwoMutableString = NSMutableAttributedString()
        sectionTwoMutableString = NSMutableAttributedString(string: sectionTwo, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Lt",
            size: 10.0)!])
        
        var network = "Tumblr"
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
