//
//  TumblrBlogCellController.swift
//  comblie
//
//  Created by Cal on 10/30/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TumblrBlogCellController: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var postStatus: UILabel!
    @IBOutlet weak var postSource: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var commentAuthor: UILabel!
    @IBOutlet weak var lineSeparator: UIView!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    @IBOutlet weak var blogLineWidth: NSLayoutConstraint!
    @IBOutlet weak var lineBlog: UIView!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    
    var VC : CommentsController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImage.layer.masksToBounds = true
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
        lineHeight.constant = CGFloat(0.5)
        blogLineWidth.constant = CGFloat(1.5)
        configureText()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        lineSeparator.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        lineBlog.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        lineSeparator.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        lineBlog.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    }
    
    //MARK: Actions
    
    @IBAction func enlarge(sender: UIButton) {
        VC = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("Comments") as! CommentsController
        VC.postHeight = self.contentView.frame.height
        self.window?.rootViewController?.presentViewController(VC, animated: true, completion: nil)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    //MARK: Other
    
    func removeComments() {
        let commentAuthorHeightConstraint = NSLayoutConstraint(item: commentAuthor, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 0)
        commentAuthor.addConstraint(commentAuthorHeightConstraint)
        
        let commentPostHeightConstraint = NSLayoutConstraint(item: commentText, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 0)
        commentText.addConstraint(commentPostHeightConstraint)
    }

    func configureText() {
        
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue, NSUnderlineColorAttributeName: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)]
        let underlineAttributedString = NSAttributedString(string: "muderita", attributes: underlineAttribute)
        self.commentAuthor.attributedText = underlineAttributedString
        
        var user = "cmonster "
        var userMutableString = NSMutableAttributedString()
        userMutableString = NSMutableAttributedString(string: user, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Medium",
            size: 13.0)!])
        
        var sectionOne = "reblogged "
        var sectionOneMutableString = NSMutableAttributedString()
        sectionOneMutableString = NSMutableAttributedString(string: sectionOne, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Roman",
            size: 13.0)!])
        
        var author = "memecat"
        var authorMutableString = NSMutableAttributedString()
        authorMutableString = NSMutableAttributedString(string: author, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Medium",
            size: 13.0)!])
        
        var sectionTwo = "'s post on "
        var sectionTwoMutableString = NSMutableAttributedString()
        sectionTwoMutableString = NSMutableAttributedString(string: sectionTwo, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Roman",
            size: 13.0)!])
        
        var network = "Tumblr"
        var networkMutableString = NSMutableAttributedString()
        networkMutableString = NSMutableAttributedString(string: network, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Medium",
            size: 13.0)!])
        
        
        userMutableString.appendAttributedString(sectionOneMutableString)
        userMutableString.appendAttributedString(authorMutableString)
        userMutableString.appendAttributedString(sectionTwoMutableString)
        userMutableString.appendAttributedString(networkMutableString)
        postStatus.attributedText = userMutableString
    }

}
