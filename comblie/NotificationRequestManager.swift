//
//  NotificationRequestManager.swift
//  comblie
//
//  Created by Trevor Hall on 10/23/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NotificationRequestManager {
    static let sharedInstance = NotificationRequestManager()
    
    
    //MARK: Feed
    func getNotificationRequest() {
        //request parameters object
        print("getFeedRequest")
        
        
        // build request parameters
        let parameters = ["meta": [
            "facebook": facebookData.returnToken(),
            "twitter": twitterData.returnToken(),
            "instagram": instagramData.returnToken(),
            "tumblr": tumblrData.returnToken(),
            "vine": vineData.returnToken()]]
        
        let url: String = "https://comblie.herokuapp.com/notifications"
        Alamofire.request(.POST, url, parameters: parameters).response { request, response, data, error in
          
            let dataJson = JSON(data: data!)
                
                // Deal with Data
                
            print("dataJson = ", dataJson)
                //                let feedData = json.rawValue
                //                let feed = JSON(feedData)
                //                print(feed["facebook"])
            print("response = ", response)  
                
            }
    }}