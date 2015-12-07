//
//  File.swift
//  comblie
//
//  Created by Trevor Hall on 10/21/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Network {

    var networkName: String = ""
    var networkToken: String = ""
    var networkUserId: String = ""
    var networkActive: Bool = false
    
    init(name: String) {
        self.networkName = name
    }
    
    func setNetworkInfo(token: String, userId: String) {
        if(token != ""){
            networkToken = token
        }
        if(userId != ""){
            print(networkName, userId)
            networkUserId = String(userId)
        }
        networkActive = true
        FeedRequestManager.sharedInstance.singleNetworkFeed(self)
    }
    
    func deleteNetworkInfo() {
        networkToken = ""
        networkUserId = ""
        networkActive = false
    }
    
    func makeNetworkActive() {
        networkActive = true
    }
    
    func makeNetworkInactive() {
        networkActive = false
    }
    
    func printNetworkInfo() {
        print("networkName = ", networkName)
        print("networkToken = ", networkToken)
        print("networkUSerId = ", networkUserId)
    }
    
    func returnToken() -> [String: String] {
        if(networkActive){
            return ["networkName": networkName, "access_token": networkToken, "id": networkUserId]
        }
        return ["networkName": networkName, "access_token": "", "id": ""]
    }
    
}











