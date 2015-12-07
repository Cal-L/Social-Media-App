//
//  InstagramAPIManager.swift
//  InstaToken
//
//  Created by Trevor Hall on 9/30/15.
//  Copyright © 2015 Trevor Hall. All rights reserved.
//

import Foundation
import Alamofire

class InstagramAPIManager {
    
    static let sharedInstance = InstagramAPIManager()
    let instagram = instagramData
    
    func startOAuth2Login()
    {
        
        let clientID: String = "59b083ff487a4bc1b139b04d74352827"
        let authPath:String = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=comblieInstagram://?aParam=paramVal&response_type=token"
        let authURL = NSURL(string: authPath)
        
        
        //redirect to safari for OAuth2 authentication
        UIApplication.sharedApplication().openURL(authURL!)
        
    }
    
    var OAuthTokenCompletionHandler:(NSError? -> Void)?
    
    
    func processOAuthStep1Response(url: NSURL) -> String
    {
        //Parse out access token from URL
        let urlString = String(url)
        let componentStringArray = urlString.componentsSeparatedByString("access_token=")
        let token = componentStringArray[1]
        instagram.setNetworkInfo(token, userId: "")
       
        //Notify NetworkLoginViewController
        let notificationKey: String = "InstagramSuccess"
        NSNotificationCenter.defaultCenter().postNotificationName(notificationKey, object: self)
        //returns Authentication Token
        return token
    }
}
