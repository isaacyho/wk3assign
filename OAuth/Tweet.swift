//
//  Tweet.swift
//  OAuth
//
//  Created by Isaac Ho on 2/19/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class Tweet : NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: String?
    var retweetCount: Int?
    var favoriteCount: Int?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        id = dictionary["id_str"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        println("Id: \(id)")
    }
    // converts createdAt to concise elapsed interval
    func getElapsedTime() -> String {
        var elapsedInterval:Double = abs(createdAt!.timeIntervalSinceNow)
        var minute = 60.0
        var hour = minute * 60
        var dayIntvl = hour * 24
        if ( elapsedInterval > dayIntvl ) {
            var x = Int( elapsedInterval / dayIntvl )
            return "\(x)d"
        } else if ( elapsedInterval > hour) {
            var x = Int( elapsedInterval / hour )
            return "\(x)h"
        } else if ( elapsedInterval > minute ) {
            var x = Int( elapsedInterval / minute )
            return "\(x)m"
        } else {
            var x = Int( elapsedInterval )
            return "\(x)s"
        }
    }
    class func tweetsWithArray( array: [NSDictionary] ) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append( Tweet( dictionary: dictionary ))
        }
        return tweets
    }
 }
