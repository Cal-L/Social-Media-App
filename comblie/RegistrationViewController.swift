//
//  RegistrationViewController.swift
//  comblie
//
//  Created by Cal on 10/8/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var bottomSpacing: NSLayoutConstraint!
    @IBOutlet weak var innerBottomSpacing: NSLayoutConstraint!
    var inputArray = [UITextField]()
    var wrongInfo : Bool!
    var badPassConf: Bool!
    var some : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add text fields to array
        inputArray.append(username)
        inputArray.append(password)
        inputArray.append(confirmPassword)
        
        // Initialize text fields
        styleTextFields()
        initializeConstraints()
        wrongInfo = false
        badPassConf = false
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func loginRedirect(sender: UIButton) {
        let pageController = self.parentViewController as! UIPageViewController
        let mainViewController = pageController.parentViewController as! MainViewController
        let viewControllers = NSArray(object: mainViewController.pages[0])
        pageController.setViewControllers(viewControllers as! [UIViewController], direction: .Reverse, animated: true, completion: nil)
        mainViewController.pageControls.currentPage = 0
    }
    
    /*func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as UIViewController
        print(some)
        var index = some.indexOfObject(vc)
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return some[index] as! UIViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as UIViewController
        var index = some.indexOfObject(vc)
        if (index == some.count-1 || index == NSNotFound) {
            return nil
        }
        index++
        return some[index] as! UIViewController
        
    }*/
    
    // Create Account Button Action
    @IBAction func CreateAccount(sender: UIButton) {
        
        // Redirect to Social Login -- You move this code or work around it
        let socialLogin = self.storyboard?.instantiateViewControllerWithIdentifier("SocialLoginPage") as! SocialLoginViewController
        self.presentViewController(socialLogin, animated: true, completion: nil)
        
        //collect user info
        let userName = username.text!
        let pass = password.text!
        let confPass = confirmPassword.text!
        
        //compare password fields to ensure they are matching
        if(confPass != pass){
            handleError("Passwords do not match!")
        } else {
            //send user info to create account if passwords match
            createAccount(userName, pass: pass)
        }
    }
    
    //Send user credentials to Firebase for registration
    func createAccount(userName: String, pass: String) {
        let ref = Firebase(url: "comblie.firebaseio.com")
        ref.createUser(userName, password: pass,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    print(error.dynamicType)
                    self.wrongInfo = true
                    self.errorLabel.alpha = CGFloat(1.0)
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                        print("error code = ", errorCode)
                        switch (errorCode) {
                            //Email address already registered
                            case .EmailTaken:
                                self.handleError("This email has already been registered")
                            //Not a valid email address
                            case .InvalidEmail:
                                self.handleError("Please enter a valid email address")
                            //Other errors
                            default:
                                self.handleError("There was a problem logging in!")
                        }
                    }
                } else {
                    let uid = result["uid"] as? String
                    if let id = uid{
                        FirebaseIOManager.sharedInstance.setUserKeychainData(id, email: userName)
                        print("Successfully created user account with uid: \(uid)")
                    } else {
                        self.handleError("There was a problem logging in!")
                    }
                }
        })
    }
    
    func handleError(error: String) {
            wrongInfo = true
            self.errorLabel.text = error
            switch error {
            case "This email has already been registered":
                emailTextRed()
                clearAllTextFields()
                break
            case "Please enter a valid email address":
                self.password.text = nil
                self.confirmPassword.text = nil
                emailTextRed()
                break
            case "Passwords do not match!":
                confirmPassword.textColor = UIColor(red: 226/255, green: 0, blue: 0, alpha: 1.0)
                passwordTextRed()
                badPassConf = true
                break
            case "There was a problem logging in!":
                self.username.text = nil
                clearAllTextFields()
                break
            default:
                break
        }
        errorLabel.alpha = CGFloat(1.0)
    }
    
    //Munipulate text fields and error label
    
    func emailTextRed() {
        self.username.textColor = UIColor(red: 226/255, green: 0, blue: 0, alpha: 1.0)
    }
    
    func passwordTextRed() {
        self.password.textColor = UIColor(red: 226/255, green: 0, blue: 0, alpha: 1.0)
    }
    
    func textFieldColorBlack() {
        self.username.textColor = UIColor.blackColor()
        self.password.textColor = UIColor.blackColor()
        self.confirmPassword.textColor = UIColor.blackColor()
    }
    
    func clearAllTextFields() {
        username.text = nil
        password.text = nil
        confirmPassword.text = nil
    }
    
    
    
    // MARK: Keyboard
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // When use starts typing
        textField.placeholder = nil
        
        // Clears appropriate fields if previously invalid
        if (wrongInfo == true) {
            if(badPassConf == true){
                badPassConf = false
                wrongInfo = false
                confirmPassword.text = nil
                errorLabel.alpha = CGFloat(0)
            } else {
                errorLabel.alpha = CGFloat(0)
                clearAllTextFields()
                wrongInfo = false
            }
            errorLabel.text = ""
        }
        self.textFieldColorBlack()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        username.placeholder = "Email Address"
        password.placeholder = "Password"
        confirmPassword.placeholder = "Confirm Password"
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
        moveForKeyboard(keyboardSize.height - innerBottomSpacing.constant - 30)
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        hideAfterKeyboard()
    }
    
    // MARK: Other
    
    func styleTextFields() {
        for field in inputArray {
            // Indents
            let spacerViewLeft = UIView(frame:CGRect(x:0, y:0, width:15, height:username.frame.height));
            let spacerViewRight = UIView(frame:CGRect(x:0, y:0, width:5, height:username.frame.height));
            field.leftViewMode = UITextFieldViewMode.Always
            field.rightViewMode = UITextFieldViewMode.Always
            field.rightView = spacerViewRight
            field.leftView = spacerViewLeft
            // Remove auto correct
            field.autocorrectionType = .No
            // Set the delegate for listening
            field.delegate = self
        }
    }
    
    func initializeConstraints() {
        let screenHeight = UIScreen.mainScreen().bounds.height
        if (screenHeight <= 480) {
            print("iPhone4")
            innerBottomSpacing.constant = 40
        } else if screenHeight == 568 {
            print("iPhone5")
            innerBottomSpacing.constant = 100
        } else {
            print("iPhone6")
            innerBottomSpacing.constant = 125
        }
    }
    
    func moveForKeyboard(keySize : CGFloat) {
        bottomSpacing.constant = keySize
        UIView.animateWithDuration(0) {
            self.view.layoutIfNeeded()
        }
        createAccountButton.enabled = false
        createAccountButton.alpha = CGFloat(0.5)
    }
    
    func hideAfterKeyboard() {
        bottomSpacing.constant = CGFloat(0.0)
        //createAccountButton.backgroundColor = UIColor(red: 132/255, green: 45/255, blue: 114/255, alpha: 1.0)
        createAccountButton.alpha = CGFloat(1.0)
        createAccountButton.enabled = true
    }
    
    // MARK: PageViewController
    
    /*func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return self
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return self
    }*/
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
