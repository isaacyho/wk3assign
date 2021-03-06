//
//  User.swift
//  OAuth
//
//  Created by Isaac Ho on 2/19/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagLine: String?
    var dictionary: NSDictionary
    var followers: Int?
    var tweets: Int?
    var following: Int?
    var synopsis: String?
    
    init( dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
        followers = dictionary["followers_count"] as? Int
        tweets = dictionary["statuses_count"] as? Int
        following = dictionary["friends_count"] as? Int
        synopsis = dictionary["description"] as? String
    }

    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    class var currentUser: User? {
        get {
            if ( _currentUser == nil ) {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil ) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject( data, forKey:currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject( nil, forKey:currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}