//
//  TwitterClient.swift
//  OAuth
//
//  Created by Isaac Ho on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit
let twitterConsumerKey = "ngPVXBFzhGLasEFoSLjZiTTQL"
let twitterConsumerSecret = "2WRLA6ppdtvgvvirezlA0XQYuEYFK1Sh40McEEIQRhfEXmm7zz"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    var loginCompletion: ((user: User?, error:NSError?) -> ())?
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL:twitterBaseURL,
            consumerKey: twitterConsumerKey,
            consumerSecret: twitterConsumerSecret )
        }
        return Static.instance
    }

    func retweet( id: String ) {
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(id).json", parameters:nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println( "retweet sent" )
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error sending retweet: \(error)")
        })
   
    }
    func favorite( id: String ) {
        var p = [String: String]()
        p["id"] = id
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json", parameters:p, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println( "favorite sent" )
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error sending favorite: \(error)")
        })

    }
    func composeTweet( text: String, inReplyToStatusId: String? ) {
        var p = [String: String]()
        
        p["status"] = text
        if ( inReplyToStatusId != nil ) {
            p["in_reply_to_status_id"] = inReplyToStatusId
        }
        
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json", parameters:p, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in

                println( "tweet sent" )
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error sending tweet: \(error)")
        })
    }
    
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) { (error: NSError!) -> Void in
                println( "\(error)")
                println("Failed to get request token")
            self.loginCompletion?(user:nil, error:error)
        }
    }
    func fetchHomeTimelineAsync( callback: ([Tweet]) -> () ) {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters:nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        println("tweets received" )
        println(response)
        println("end response")
        var tweets = Tweet.tweetsWithArray( response as [NSDictionary])
        for t in tweets {
            println( "text: \(t.text), created: \(t.createdAt)" )
        }
        callback( tweets )
            
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        println("error getting home timeline: \(error)")
        })
    }
    
    
    
    func openURL( url: NSURL ) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential( queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) ->
            Void in
            println("received access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken( accessToken )
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json",
                parameters:nil, success: { (operation: AFHTTPRequestOperation!,
                    response: AnyObject!) -> Void in
                    var user = User(dictionary: response as NSDictionary)
                    User.currentUser = user
                    println( "got user: \(user.name)" )
                    self.loginCompletion?(user:user, error:nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println ("error getting user" )
                    self.loginCompletion?(user:nil, error:error)

            })
            
              }) { (error: NSError!) -> Void in
                println("Failed to receive access token")
                self.loginCompletion?(user:nil, error:error)

        }
        
     
        
    }
}
