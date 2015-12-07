//
//  MessageRoomViewController.swift
//  comblie
//
//  Created by Cal on 10/21/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class MessageRoomViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var messageRoomView: UIView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var bottomSpacing: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let messageTable = self.storyboard?.instantiateViewControllerWithIdentifier("MessageRoomTableViewController") as! MessageRoomTableViewController
        self.addChildViewController(messageTable)
        messageTable.view.frame = CGRect(x: 0, y: 0, width: self.messageRoomView.frame.width, height: messageRoomView.frame.height)
        self.messageRoomView.addSubview(messageTable.view)
        self.registerForKeyboardNotifications()
        styleTextField()
    }
    
    // MARK: Action
    
    
    @IBAction func goBack(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func styleTextField() {
        
        let spacerViewLeft = UIView(frame:CGRect(x:0, y:0, width:5, height:messageField.frame.height));
        messageField.leftViewMode = UITextFieldViewMode.Always
        messageField.leftView = spacerViewLeft
        
        
        // Remove auto correct
        messageField.autocorrectionType = .No
        // Set the delegate for listening
        messageField.delegate = self
        
    }
    
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
