//
//  SocialLoginViewController.swift
//  comblie
//
//  Created by Cal on 10/8/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import OAuthSwift
import TwitterKit

class SocialLoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var facebookLogin: UITextField!
    @IBOutlet weak var twitterLogin: UITextField!
    @IBOutlet weak var instagramLogin: UITextField!
    @IBOutlet weak var tumblrLogin: UITextField!
    @IBOutlet weak var vineLogin: UITextField!
    @IBOutlet weak var facebookConnect: UIButton!
    @IBOutlet weak var tumblrConnect: UIButton!
    @IBOutlet weak var instagramConnect: UIButton!
    @IBOutlet weak var twitterConnect: UIButton!
    @IBOutlet weak var vineConnect: UIButton!
    
    @IBOutlet weak var busyOverlay: UIView!
    @IBOutlet weak var innerBottomSpacing: NSLayoutConstraint!
    @IBOutlet weak var bottomSpacing: NSLayoutConstraint!
    let facebook = facebookData
    let twitter = twitterData
    let instagram = instagramData
    let tumblr = tumblrData
    let vine = vineData
    var socialTextFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        instagramLogin.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        //Add listener for Instagram Success
        let notificationKey: String = "InstagramSuccess"
        let loggedInNotificationKey: String = "UserLoggedIn"
        let vineNotification: String = "VineSuccess"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "instagramLoginSuccess", name: notificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLoggedIn", name: loggedInNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "vineLoginSuccess", name: vineNotification, object: nil)
        
        // Initialize text fields
        initializeTextFields()
        initializeConstraints()
        initializeConnectButtons()
        initializeFacebookLoginButton()
        initializeTwitterLoginButton()
        
        

        //Check for connected networks
        checkNetworkLogins()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    //MARK: Actions
    
    func socialLogin(sender: UIButton) {
        //Trigger correct network login process
        print(sender)
        switch sender {
        case facebookConnect:
            startFacebookLogin()
            break
        case instagramConnect:
            startInstagramLogin()
            break
        case twitterConnect:
            startTwitterLogin()
            break
        case tumblrConnect:
            startTumblrLogin()
            break
        case vineConnect:
            startVineLogin()
            break
        default:
            break
        }

    }
    

    
    //MARK: Network Login State
    func userLoggedIn () {
        checkNetworkLogins()
        print("User Logged In")
    }
    
    func checkNetworkLogins() {
        
        let buttons: [UIButton] = [facebookConnect, twitterConnect,instagramConnect, tumblrConnect, vineConnect]
        let loginFields: [UITextField] = [facebookLogin, twitterLogin, instagramLogin, tumblrLogin, vineLogin]
        let tokens = [facebook.networkToken, twitter.networkToken, instagram.networkToken, tumblr.networkToken, vine.networkToken]
        
        for index in 0 ... buttons.count - 1 {
            if(tokens[index] == ""){
                networkDisconnected(buttons[index], textField: loginFields[index])
            } else {
                networkConnected(buttons[index], textField: loginFields[index])
            }
        }
    }
    
    func networkConnected(button: UIButton, textField: UITextField) {
        let fontLight = UIFont(name: "HelveticaNeue-Light", size: 14)
        let lightGray = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
        button.setTitle("Connected ✔︎", forState: .Selected)
        button.setTitleColor(lightGray, forState: .Selected)
        button.titleLabel?.font = fontLight
        button.selected = true
        textField.font = fontLight
        textField.textColor = lightGray
    }
    
    
    //MARK: CAL - please style the UIButtons and UITextFields back to the non-connected state here for network logout
    func networkDisconnected(button: UIButton, textField: UITextField) {
        let fontMedium = UIFont(name: "HelveticaNeue-Medium", size: 14)
        let fontRoman = UIFont(name: "HelveticaNeue-Roman", size: 14)
        let purpleFade = UIColor(red: 132/255, green: 45/255, blue: 114/255, alpha: 1.0)
        button.setTitle("Connect", forState: .Normal)
        button.setTitleColor(purpleFade, forState: .Normal)
        button.titleLabel?.font = fontMedium
        button.selected = false
        textField.font = fontRoman
        textField.textColor = UIColor.blackColor()
    }
    
    //MARK: -Facebook Login
    
    func startFacebookLogin() {
        // Triggers the facebook button
        
        if(facebook.networkToken == "" &&  FBSDKAccessToken.currentAccessToken() == nil) {
            triggerFacebookButton()
        } else if( facebook.networkToken == "" &&  FBSDKAccessToken.currentAccessToken() != nil ){
            let token = FBSDKAccessToken.currentAccessToken().tokenString
            let userId = FBSDKAccessToken.currentAccessToken().userID
            if let auth_token = token, id = userId {
                facebook.setNetworkInfo(auth_token, userId: id)
            }
        } else if(facebook.networkToken != "" &&  FBSDKAccessToken.currentAccessToken() != nil) {
            triggerFacebookButton()
        } else {
            facebook.deleteNetworkInfo()
        }
        checkNetworkLogins()
    }
    
    func triggerFacebookButton() {
        for subview in self.view.subviews {
            if subview.tag == 2009 {
                let defaultFacebookButton = subview as! FBSDKLoginButton
                defaultFacebookButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
        }
    }
    
    func initializeFacebookLoginButton() {
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("logged in")
        }
        else
        {
            print("not logged in")
        }
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends", "user_likes", "user_posts"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        loginButton.tag = 2009
        loginButton.alpha = CGFloat(0)
        
        self.view.addSubview(loginButton)
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if(error == nil) {
            print("Login Complete")
            if(FBSDKAccessToken.currentAccessToken() == nil) {
                checkNetworkLogins()
            } else {
                let token = FBSDKAccessToken.currentAccessToken().tokenString
                let userID = FBSDKAccessToken.currentAccessToken().userID
                if let currentToken = token, id = userID {
                    facebook.setNetworkInfo(currentToken, userId: id)
                }
            }
            
        }
        else {
            print("error")
        }
        checkNetworkLogins()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out")
        facebook.deleteNetworkInfo()
        checkNetworkLogins()
    }
    
    // MARK: Twitter
    
    func startTwitterLogin() {
                if(twitter.networkToken == "") {
                    initializeTwitterButton()
                } else {
                    twitter.deleteNetworkInfo()
                    checkNetworkLogins()
                }
    }
    
    func initializeTwitterButton() {
        // Triggers the facebook button
        for subview in self.view.subviews {
            if subview.tag == 2012 {
                let defaultTwitterButton = subview as! TWTRLogInButton
                defaultTwitterButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
        }
    }
    
    func initializeTwitterLoginButton() {
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                if let userInfo = session {
                    print("secret",userInfo.authTokenSecret)
                    print("token",userInfo.authToken)
                    self.twitter.setNetworkInfo(userInfo.authToken, userId: userInfo.userID)
                    self.checkNetworkLogins()
                }
            } else {
                print("error: \(error!.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        logInButton.tag = 2012
        logInButton.alpha = CGFloat(0.0)
        self.view.addSubview(logInButton)
        
    }
    

    
    //MARK: Instagram Login
    func startInstagramLogin() {
        if(instagram.networkToken == "") {
            InstagramAPIManager.sharedInstance.startOAuth2Login()
        } else {
            instagram.deleteNetworkInfo()
            checkNetworkLogins()
        }
    }
    
    func instagramLoginSuccess () {
        print("instagramLoginSuccess")
        let token = instagram.networkToken
        networkConnected(instagramConnect, textField: instagramLogin)
        print(token)
    }
    
    
    //MARK: Tumblr Login
    func startTumblrLogin() {
        if(tumblr.networkToken == "") {
            tumblrLoginProcess()
        } else {
            tumblr.deleteNetworkInfo()
            checkNetworkLogins()
        }
    }
    
    func tumblrLoginProcess() {
        let oauthswift = OAuth1Swift(
            consumerKey:    "IJLNxgo0hZ4oPLa5eb86BMrgks2HOZbZ5y8iUhYtSHEWPdE50J",
            consumerSecret: "SCo8PWk4ET5bH3RzrgVCp3HOjJ8GSA9ZP2ajk8s2eImE9Yk7id",
            requestTokenUrl: "https://www.tumblr.com/oauth/request_token",
            authorizeUrl:    "https://www.tumblr.com/oauth/authorize",
            accessTokenUrl:  "https://www.tumblr.com/oauth/access_token"
        )
        oauthswift.authorizeWithCallbackURL( NSURL(string: "comblieTumblr://oauth-callback/tumblr")!, success: {
            credential, response in
                print("tumblrCredentials")
            print("tumblr token = ", credential.oauth_token, " of type ", credential.oauth_token.dynamicType)
            print("secret = ", credential.oauth_token_secret, "of type", credential.oauth_token_secret.dynamicType)
                self.tumblr.setNetworkInfo(credential.oauth_token, userId: credential.oauth_token_secret)
                self.checkNetworkLogins()

            }, failure: {(error:NSError!) -> Void in
                print(error.localizedDescription)
        })
        
    }
    
    //MARK: Vine
    func startVineLogin() {
        if(vine.networkToken == ""){
            openVineLogin()
        } else {
            vine.deleteNetworkInfo()
            checkNetworkLogins()
        }
    }
    
    func openVineLogin() {
        
        // For modal window login
        //self.view.bringSubviewToFront(busyOverlay)
        let VC : VineLoginController = (self.storyboard?.instantiateViewControllerWithIdentifier("VineLoginWindow")) as! VineLoginController
        VC.providesPresentationContextTransitionStyle = true
        VC.definesPresentationContext = true
        VC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(VC, animated: true, completion: nil)
        
    }
    
    func vineLoginSuccess(){
        checkNetworkLogins()
    }
    
    
    

    


    

    // MARK: Finish Network Login
    
    // Create Account Button Action
    @IBAction func finishButton(sender: UIButton) {
//        print("Finish Social")
//        
//        let VC = self.storyboard!.instantiateViewControllerWithIdentifier("SocialTabBar")
//        self.presentViewController(VC, animated: true, completion: nil)
        FirebaseIOManager.sharedInstance.storeTokensInFirebase()
        FeedRequestManager.sharedInstance.getFeedRequest()
//        NotificationRequestManager.sharedInstance.getNotificationRequest()
    }
    


    
    // MARK: Keyboard
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // When use starts typing
        print("editing")
        //textField.enabled = false
        textField.placeholder = nil
        
        // Clears if previously invalid
        if (textField.textColor == UIColor.redColor()) {
            facebookLogin.text = nil
            twitterLogin.text = nil
            instagramLogin.text = nil
            tumblrLogin.text = nil
            vineLogin.text = nil
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        facebookLogin.placeholder = "Facebook"
        twitterLogin.placeholder = "Twitter"
        instagramLogin.placeholder = "Instagram"
        tumblrLogin.placeholder = "Tumblr"
        vineLogin.placeholder = "Vine"
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
        moveForKeyboard(keyboardSize.height - innerBottomSpacing.constant)
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        hideAfterKeyboard()
    }
    
    // MARK: Other
    
    func initializeConnectButtons() {
        
        // Adds buttons to listener
        facebookConnect.addTarget(self, action: "socialLogin:", forControlEvents: UIControlEvents.TouchUpInside)
        twitterConnect.addTarget(self, action: "socialLogin:", forControlEvents: UIControlEvents.TouchUpInside)
        instagramConnect.addTarget(self, action: "socialLogin:", forControlEvents: UIControlEvents.TouchUpInside)
        tumblrConnect.addTarget(self, action: "socialLogin:", forControlEvents: UIControlEvents.TouchUpInside)
        vineConnect.addTarget(self, action: "socialLogin:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func initializeTextFields() {
        
        // Add text fields to array
        socialTextFields.append(facebookLogin)
        socialTextFields.append(twitterLogin)
        socialTextFields.append(instagramLogin)
        socialTextFields.append(tumblrLogin)
        socialTextFields.append(vineLogin)
        
        // Adds indentation on the left
        for field in socialTextFields {
            // Disable keyboard
            field.enabled = false
            // Indents
            let spacerViewLeft = UIView(frame:CGRect(x:0, y:0, width:25, height:facebookLogin.frame.height));
            field.leftViewMode = UITextFieldViewMode.Always
            field.leftView = spacerViewLeft
            // Remove auto correct
            field.autocorrectionType = .No
            // Set the delegate for listening
            field.delegate = self
        }
    }
    
    
    func initializeConstraints() {
        
        // Initializes layout to fit
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
        finishButton.enabled = false
        finishButton.alpha = CGFloat(0.5)
    }
    
    func hideAfterKeyboard() {
        bottomSpacing.constant = CGFloat(0.0)
        //createAccountButton.backgroundColor = UIColor(red: 132/255, green: 45/255, blue: 114/255, alpha: 1.0)
        finishButton.alpha = CGFloat(1.0)
        finishButton.enabled = true
    }
    
    //MARK: May Not Need These
    

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
