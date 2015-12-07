//
//  VineLoginController.swift
//  comblie
//
//  Created by Cal on 10/20/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VineLoginController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    let vine = vineData

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        styleLoginPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        let email = username.text!
        let pass = password.text!
        vineLogin(email, password: pass)
        
    }
    
    func vineLogin(username: String, password: String){
        let url = "https://api.vineapp.com/users/authenticate"
        let headers = ["username": "trevorwhall@gmail.com",
            "password": "Teamlove1"]
        Alamofire.request(.POST, url, parameters: headers).response { request, response, data, error in
            if(error != nil){
                print("error = ", error)
            } else {
                let dataJson = JSON(data: data!)
                print(dataJson)
                self.vine.setNetworkInfo(dataJson["data"]["key"].stringValue, userId: dataJson["data"]["userId"].stringValue)
                self.vineNotification()
            }
        }
    }
    
    func vineNotification () {
        let notificationKey: String = "VineSuccess"
        NSNotificationCenter.defaultCenter().postNotificationName(notificationKey, object: self)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func styleLoginPage() {
        loginButton.layer.cornerRadius = CGFloat(5.0)
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
