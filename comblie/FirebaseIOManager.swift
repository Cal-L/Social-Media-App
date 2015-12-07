//
//  FirebaseIOManager.swift
//  comblie
//
//  Created by Trevor Hall on 10/18/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import Foundation
import Firebase

class FirebaseIOManager {
    static let sharedInstance = FirebaseIOManager()
    
    let facebook = facebookData
    let twitter = twitterData
    let instagram = instagramData
    let tumblr = tumblrData
    let vine = vineData
    
    func setUserKeychainData (userID: String, email: String) {
        KeychainWrapper.setString(userID, forKey: "ComblieUserID")
        KeychainWrapper.setString(email, forKey: "ComblieUserEmail")
    }
    
    //MARK: Get Tokens from Firebase
    func getUserData (userID: String, email: String) {
        print("get user data")
        print(userID)
        
        let ref = Firebase(url:"https://comblie.firebaseio.com/users/" + userID)
        
        // Attach a closure to read the data at our posts reference
        ref.observeEventType(.Value, withBlock: { snapshot in
            UserDataManager.sharedInstance.setUserData(snapshot.value ,userID: userID, email: email)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    //MARK: Store Tokens to Firebase
    func storeTokensInFirebase() {
        //User Info
        let userID =    UserDataManager.sharedInstance.comblieUserId
        let email =     UserDataManager.sharedInstance.comblieEmailAddress
        

        // build request parameters
        let userData = ["email": email,
            "facebook": facebook.returnToken(),
            "twitter": twitter.returnToken(),
            "instagram": instagram.returnToken(),
            "tumblr": tumblr.returnToken(),
            "vine": vine.returnToken()]
        
        //Firebase request to store Users data
        let ref =  Firebase(url: "https://comblie.firebaseio.com/")
        let usersRef = ref.childByAppendingPath("users")
        let userIDRef = usersRef.childByAppendingPath(userID)
        userIDRef.setValue(userData)
    }


    
}