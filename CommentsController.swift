//
//  CommentsController.swift
//  comblie
//
//  Created by Cal on 11/7/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class CommentsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var topTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var likesText: UILabel!
    @IBOutlet weak var commentBox: UITextField!
    @IBOutlet weak var bottomSpacing: NSLayoutConstraint!
    
    var postHeight : CGFloat!
    var cell : UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView
        
        //Set delegate controls and datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.topTableView.delegate = self
        self.topTableView.dataSource = self
        
        //Register XIBs for cell reuse
        self.topTableView.registerNib(UINib(nibName: "FacebookStatusCell", bundle: nil), forCellReuseIdentifier: "FacebookStatus")
        self.topTableView.registerNib(UINib(nibName: "TwitterTweetCell", bundle: nil), forCellReuseIdentifier: "TwitterTweet")
        self.topTableView.registerNib(UINib(nibName: "TwitterPhotoCell", bundle: nil), forCellReuseIdentifier: "TwitterPhoto")
        self.topTableView.registerNib(UINib(nibName: "TumblrPhotoCell", bundle: nil), forCellReuseIdentifier: "TumblrPhoto")
        self.topTableView.registerNib(UINib(nibName: "TumblrBlogCell", bundle: nil), forCellReuseIdentifier: "TumblrBlog")
        self.topTableView.registerNib(UINib(nibName: "InstagramFeedCell", bundle: nil), forCellReuseIdentifier: "InstagramFeed")
        self.tableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "Comment")
        
        //Styles Tableviews and sets autoheight
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.topTableView.estimatedRowHeight = 44
        self.topTableView.rowHeight = UITableViewAutomaticDimension
        self.topTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.topTableHeight.constant = self.postHeight
        self.registerForKeyboardNotifications()

        configureLikesText()
        styleTextField()
    }

    //MARK: Actions
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //UITableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.topTableView {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //For top table view
        if tableView == self.topTableView {
            let currentCell = self.topTableView.dequeueReusableCellWithIdentifier("InstagramFeed", forIndexPath: indexPath) as! InstagramFeedCellController
            currentCell.likeCommentBox.alpha = CGFloat(1)
            currentCell.postTime.removeFromSuperview()
            currentCell.playButton.alpha = CGFloat(0)
            currentCell.userInteractionEnabled = false
            cell = currentCell
            
        }
        //For comments table view
        else {
            cell = self.tableView.dequeueReusableCellWithIdentifier("Comment", forIndexPath: indexPath)
        }
        return cell
    }
   
    //Other
    func styleTextField() {
        
        let spacerViewLeft = UIView(frame:CGRect(x:0, y:0, width:5, height:self.commentBox.frame.height));
        self.commentBox.leftViewMode = UITextFieldViewMode.Always
        self.commentBox.leftView = spacerViewLeft
        
        
        // Remove auto correct
        self.commentBox.autocorrectionType = .No
        // Set the delegate for listening
        self.commentBox.delegate = self
        
    }
    
    func configureLikesText() {
        var user = "Sara Sampaio "
        var userMutableString = NSMutableAttributedString()
        userMutableString = NSMutableAttributedString(string: user, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Medium",
            size: 10.5)!])
        
        var sectionOne = "and "
        var sectionOneMutableString = NSMutableAttributedString()
        sectionOneMutableString = NSMutableAttributedString(string: sectionOne, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Roman",
            size: 10.5)!])
        
        var othersCount = "21,653 others "
        var othersCountMutableString = NSMutableAttributedString()
        othersCountMutableString = NSMutableAttributedString(string: othersCount, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Medium",
            size: 10.5)!])
        
        var sectionTwo = "liked this."
        var sectionTwoMutableString = NSMutableAttributedString()
        sectionTwoMutableString = NSMutableAttributedString(string: sectionTwo, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-Roman",
            size: 10.5)!])
        
        userMutableString.appendAttributedString(sectionOneMutableString)
        userMutableString.appendAttributedString(othersCountMutableString)
        userMutableString.appendAttributedString(sectionTwoMutableString)
        self.likesText.attributedText = userMutableString
    }
    
    // Dynamic keyboard & textfield
    
    // Allows the return button to dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeShown(sender: NSNotification) {
        
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        
        // MOVE THE CONTENT UP FOR THE KEYBOARD
        moveForKeyboard(keyboardSize.height)
        
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        hideAfterKeyboard()
    }
    
    func moveForKeyboard(keySize : CGFloat) {
        bottomSpacing.constant = keySize
        UIView.animateWithDuration(0) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideAfterKeyboard() {
        bottomSpacing.constant = CGFloat(0.0)
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
