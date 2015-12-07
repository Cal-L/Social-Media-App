//
//  TwitterTweetCellController.swift
//  comblie
//
//  Created by Cal on 10/28/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TwitterTweetCellController: UITableViewCell, UINavigationBarDelegate {
    
    var parent : UITableViewController!
    //var row : NSIndexPath!
    
    // MARK: Properties
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postAuthor: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var lineSeparator: UIView!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetTextHeight: NSLayoutConstraint!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    var VC : CommentsController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
        self.lineHeight.constant = CGFloat(0.5)
        // Set the post texts
        configurePostText()
        configurePostAuthor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        lineSeparator.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        lineSeparator.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }
    
    //MARK: Actions
    
    
    @IBAction func enlarge(sender: UIButton) {
        VC = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("Comments") as! CommentsController
        VC.postHeight = self.contentView.frame.height
        self.window?.rootViewController?.presentViewController(VC, animated: true, completion: nil)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    @IBAction func a(sender: UIButton) {
        //UPDATES MAIN TABLE VIEW LIVE
        
        //self.parent.tableView.beginUpdates()
        //self.retweetTextHeight.constant = CGFloat(0.0)
        /*self.postText.numberOfLines = 1
        self.parent.tableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.None)
        //self.parent.tableView.endUpdates()*/
        
    }
    
    func openProfile() {
        let profileView = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("PublicProfile")
        self.parent.parentViewController!.navigationController?.pushViewController(profileView!, animated: true)
    }
    
    func configurePostText() {
        var post = "Meek Mill just released a Drake diss track"
        var postMutableString = NSMutableAttributedString()
        postMutableString = NSMutableAttributedString(string: post, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Roman",
            size: 13.0)!])
        
        var hashtag = "#fire"
        var hashtagMutableString = NSMutableAttributedString()
        hashtagMutableString = NSMutableAttributedString(string: hashtag, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Medium",
            size: 13.0)!])
        
        postMutableString.appendAttributedString(hashtagMutableString)
        self.postText.attributedText = postMutableString
    }
    
    func configurePostAuthor() {
        var name = "David Beckham "
        var nameMutableString = NSMutableAttributedString()
        nameMutableString = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Medium",
            size: 13.0)!])
        
        var alias = "@officialbeckham"
        var aliasMutableString = NSMutableAttributedString()
        aliasMutableString = NSMutableAttributedString(string: alias, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Light",
            size: 12.5)!])
        
        nameMutableString.appendAttributedString(aliasMutableString)
        self.postAuthor.attributedText = nameMutableString
        // if labelView is not set userInteractionEnabled, you must do so
        self.postAuthor.userInteractionEnabled = true
        self.postAuthor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "openProfile"))
        
    }

}
