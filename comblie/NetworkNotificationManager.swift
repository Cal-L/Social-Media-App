//
//  NetworkNotificationManager.swift
//  comblie
//
//  Created by Trevor Hall on 10/23/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import Foundation
import SwiftyJSON

let facebookNotification = NetworkNotification(name: "facebook"),
    twitterNotification = NetworkNotification(name: "twitter"),
    instagramNotification = NetworkNotification(name: "instagram"),
    tumblrNotification = NetworkNotification(name: "tumblr"),
    vineNotification = NetworkNotification(name: "vine"),
    comblieNotification = NetworkNotification(name: "comblie")

class NetworkNotification {
    let networkName: String
    var networkNotifications = []
    
    init(name: String){
        self.networkName = name
    }
    
    func initNotifications(data: JSON) {
        print(data)
    }
    
    func appendNotifications(data: JSON) {
        
    }
    
    func prependNotifications(data: JSON) {
        
    }
}