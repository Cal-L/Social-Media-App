//
//  APITokenManager.swift
//  InstaToken
//
//  Created by Trevor Hall on 10/2/15.
//  Copyright © 2015 Trevor Hall. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class UserDataManager {
    
    static let sharedInstance = UserDataManager()
    let facebook = facebookData
    let twitter = twitterData
    let instagram = instagramData
    let tumblr = tumblrData
    let vine = vineData
    
    var comblieUserId = ""
    var comblieEmailAddress = ""
    
    func setUserData(tokens: AnyObject, userID: String, email: String) {
        print("APITokenManager setUserData")
        let tokensJSON = JSON(tokens)
        comblieUserId = userID
        comblieEmailAddress = email

        facebook.setNetworkInfo(tokensJSON["facebook"]["access_token"].stringValue, userId: tokensJSON["facebook"]["userId"].stringValue)
        twitter.setNetworkInfo(tokensJSON["twitter"]["access_token"].stringValue, userId: tokensJSON["twitter"]["userId"].stringValue)
        instagram.setNetworkInfo(tokensJSON["instagram"]["access_token"].stringValue, userId: tokensJSON["instagram"]["userId"].stringValue)
        tumblr.setNetworkInfo(tokensJSON["tumblr"]["access_token"].stringValue, userId: tokensJSON["tumblr"]["userId"].stringValue)
        vine.setNetworkInfo(tokensJSON["vine"]["access_token"].stringValue, userId: tokensJSON["vine"]["userId"].stringValue)

        let notificationKey: String = "UserLoggedIn"
        NSNotificationCenter.defaultCenter().postNotificationName(notificationKey, object: self)
    }
    
    func checkNetworkToken(network: Network) {
        
    }
    
    
    
}