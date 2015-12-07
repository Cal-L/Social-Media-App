//
//  LoginPageViewController.swift
//  comblie
//
//  Created by Cal on 10/8/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bottomSpacing: NSLayoutConstraint!
    @IBOutlet weak var innerBottomSpacing: NSLayoutConstraint!
    var inputArray = [UITextField]()
    var wrongInfo : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add text fields to array
        inputArray.append(username)
        inputArray.append(password)
        
        // Initialize text fields
        styleTextFields()
        initializeConstraints()
        wrongInfo = false

    }
    

    
    //MARK: Actions
    
    @IBAction func signupRedirect(sender: UIButton) {
        let pageController = self.parentViewController as! UIPageViewController
        let mainViewController = pageController.parentViewController as! MainViewController
        let viewControllers = NSArray(object: mainViewController.pages[1])
        pageController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
        mainViewController.pageControls.currentPage = 1
    }
    
    // Login Account Button Action
    @IBAction func loginButtonAction(sender: UIButton) {

        let email = username.text!
        let pass = password.text!
        
        let ref = Firebase(url: "comblie.firebaseio.com")
        ref.authUser(email, password: pass,
            withCompletionBlock: { error, result in
                if error != nil {
                    print("error = ", error)
                    if let errorCode = FAuthenticationError(rawValue: error.code){
                        switch (errorCode) {
                        case .UserDoesNotExist:
                            self.handleError("Invalid Username!")
                        case .InvalidEmail:
                            self.handleError("Please enter a valid email address")
                        case .InvalidPassword:
                            self.handleError("Wrong Password!")
                        default:
                            self.handleError("Error")
                        }
                    }
                } else {
                    // We are now logged in
                    if let userID = result.uid {
                        self.handleSuccessfulLogin(userID, email: email)
                        print("success")
                    }
                }
        })
    }
    
    func socialNetworkLoginPage() {
        
        // Redirect to Social Login -- You move this code or work around it
        let socialLogin = self.storyboard?.instantiateViewControllerWithIdentifier("SocialLoginPage") as! SocialLoginViewController
        self.presentViewController(socialLogin, animated: true, completion: nil)
        
    }
    
    func handleSuccessfulLogin(userId: String, email: String) {
        
        FirebaseIOManager.sharedInstance.setUserKeychainData(userId, email: email)
        FirebaseIOManager.sharedInstance.getUserData(userId, email: email)
        socialNetworkLoginPage()
        
    }

    
    func handleError(error: String) {
        wrongInfo = true
        self.errorLabel.text = error
        switch error {
            case "Invalid Username!":
                emailTextRed()
                break
            case "Please enter a valid email address":
                emailTextRed()
                break
            case "Wrong Password!":
                passwordTextRed()
                break
            case "error":
                self.username.text = nil
                break
            default:
                print("error")
        }
    }

    //MARK: Change Text
    func emailTextRed() {
        self.username.textColor = UIColor(red: 226/255, green: 0, blue: 0, alpha: 1.0)
        self.password.text = nil
    }
    
    func passwordTextRed() {
        self.password.textColor = UIColor(red: 226/255, green: 0, blue: 0, alpha: 1.0)

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.registerForKeyboardNotifications()
//        if(UserDataManager.sharedInstance.comblieUserId != ""){
//            let socialLogin = self.storyboard?.instantiateViewControllerWithIdentifier("SocialLoginPage") as! SocialLoginViewController
//            self.presentViewController(socialLogin, animated: true, completion: nil)
//        }
    }
    
    // MARK: Keyboard
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // When use starts typing
        textField.placeholder = nil
        
        // Clears if previously invalid
        if (wrongInfo == true) {
            self.username.textColor = UIColor.blackColor()
            self.password.textColor = UIColor.blackColor()
            errorLabel.alpha = CGFloat(0)
            wrongInfo = false
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        username.placeholder = "Email Address"
        password.placeholder = "Password"
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
            field.delegate = self        }
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
        loginButton.enabled = false
        loginButton.alpha = CGFloat(0.5)
    }
    
    func hideAfterKeyboard() {
        bottomSpacing.constant = CGFloat(0.0)
        //loginButton.backgroundColor = UIColor(red: 132/255, green: 45/255, blue: 114/255, alpha: 1.0)
        loginButton.alpha = CGFloat(1.0)
        loginButton.enabled = true
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
