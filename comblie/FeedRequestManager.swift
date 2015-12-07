//
//  HTTPRequestManager.swift
//  InstaToken
//
//  Created by Trevor Hall on 10/2/15.
//  Copyright © 2015 Trevor Hall. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

 public class FeedRequestManager {
    
    static let sharedInstance = FeedRequestManager()
    
    let facebook = facebookData
    let twitter = twitterData
    let instagram = instagramData
    let tumblr = tumblrData
    let vine = vineData

    
    //MARK: Feed
    func getFeedRequest() {
        //request parameters object
        print("getFeedRequest")
        
        
        // build request parameters
        let parameters = ["meta": [
            "facebook": facebook.returnToken(),
            "twitter": twitter.returnToken(),
            "instagram": instagram.returnToken(),
            "tumblr": tumblr.returnToken(),
            "vine": vine.returnToken()]]

        let url: String = "https://comblie.herokuapp.com/feed/"
        // verify parameters is a valid json
        let object = NSJSONSerialization.isValidJSONObject(parameters)
        
        //if parameters is a valid object, make POST request to server
        if(object){
            Alamofire.request(.POST, url, parameters: parameters).response { request, response, data, error in
//                let json = JSON(request!)
                let dataJson = JSON(data: data!)
                
                // Deal with Data
                
                print("dataJson = ", dataJson)
//                let feedData = json.rawValue
//                let feed = JSON(feedData)
//                print(feed["facebook"])
//                print("response = ", response)
                InstagramFeedData.initFeedData(dataJson["response"]["instagram"])
                

            }
        }
    }
    
    func singleNetworkFeed(network: Network) {
        network.printNetworkInfo()
    }
}