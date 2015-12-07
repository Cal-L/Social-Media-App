//
//  NetworkFeedClass.swift
//  comblie
//
//  Created by Trevor Hall on 10/23/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import Foundation
import SwiftyJSON

let FacebookFeedData =  NetworkFeed(name: "facebook"),
    TwitterFeedData = NetworkFeed(name: "twitter"),
    InstagramFeedData = NetworkFeed(name: "instagram"),
    TumblrFeedData =  NetworkFeed(name:"tumblr"),
    VineFeedData = NetworkFeed(name: "vine"),
    ComblieFeedData = NetworkFeed(name: "comblie")


class NetworkFeed {
    var networkName: String = "",
        networkFeedData = []
    
    init(name: String){
        self.networkName = name
    }
    
    func initFeedData(data: JSON) {
        print(data["data"][0]["images"]["standard_resolution"]["url"])
    }
    
    func appendFeedData(data: JSON) {
        
    }
    
    func prependFeedData(data: JSON) {
        
        
    }
    
}