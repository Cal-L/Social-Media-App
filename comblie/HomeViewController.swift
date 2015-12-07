//
//  ViewController.swift
//  comblie
//
//  Created by Cal on 10/8/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the SignUp button style
        signUpButton.layer.cornerRadius = CGFloat(20.0)
        signUpButton.layer.borderWidth = CGFloat(1.2);
        signUpButton.layer.borderColor = UIColor.purpleColor().CGColor
        
    }
    
    override func viewDidAppear(animated: Bool) {
//            let socialLogin = self.storyboard?.instantiateViewControllerWithIdentifier("SocialLoginPage") as! SocialLoginViewController
//            self.presentViewController(socialLogin, animated: true, completion: nil)
    }
    
    // Mark : Actions
    
    @IBAction func registerButton(sender: UIButton) {
        let VC : MainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! MainViewController
        VC.pageQuery = "Register"
        self.presentViewController(VC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func loginButton(sender: UIButton) {
        
        let VC : MainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! MainViewController
        VC.pageQuery = "Login"
        self.presentViewController(VC, animated: true, completion: nil)
    }


}

