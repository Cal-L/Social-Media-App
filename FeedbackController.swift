//
//  FeedbackController.swift
//  comblie
//
//  Created by Cal on 11/4/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class FeedbackController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var reportText: UITextView!
    @IBOutlet weak var grayBarHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomBarHeight: NSLayoutConstraint!
    var placeholderColor : UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let me = NSUserDefaults.standardUserDefaults()
        print(me.boolForKey("facebook"))
        // Do any additional setup after loading the view.
        self.grayBarHeight.constant = CGFloat(0.5)
        self.bottomBarHeight.constant = CGFloat(0.5)
        self.placeholderColor = UIColor(red: 187/255, green: 187/255, blue: 190/255, alpha: 1)
        self.reportText.textColor = placeholderColor
        self.reportText.delegate = self
    }
    
    
    //MARK: Action
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == self.placeholderColor {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == "" {
            textView.text = "What would you like for us to improve?"
            textView.textColor = self.placeholderColor
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
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
