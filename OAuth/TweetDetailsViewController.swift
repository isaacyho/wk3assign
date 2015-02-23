//
//  TweetDetailsViewController.swift
//  OAuth
//
//  Created by Isaac Ho on 2/22/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    var tweetCell: TweetCell?
    @IBOutlet weak var atUserName: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var faveLabel: UILabel!
    var replyUserName: String?
    var replyStatusId: String?
    var replyStatusText: String?
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweetCell!.tweet!.id!)

    }
    @IBOutlet weak var text: UILabel!
    @IBAction func onReply(sender: AnyObject) {
        replyUserName = tweetCell!.tweet!.user!.screenName
        replyStatusId = tweetCell!.tweet!.id!
        replyStatusText = tweetCell!.tweet!.text!
        
        performSegueWithIdentifier("composeSegue", sender: nil)
    }
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetCell!.tweet!.id!)
    }
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        mainImage.setImageWithURL( NSURL(string: tweetCell!.tweet!.user!.profileImageUrl!))
        atUserName.text = tweetCell!.username.text
        fullName.text = tweetCell!.fullname.text
        text.text = tweetCell!.message.text
        dateAndTimeLabel.text = tweetCell!.tweet!.createdAtString
        faveLabel.text = "\(tweetCell!.tweet!.favoriteCount!) favorites"
        retweetLabel.text = "\(tweetCell!.tweet!.retweetCount!) retweets"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if ( segue.identifier == "composeSegue" ) {

        var vc = ( segue.destinationViewController as UINavigationController ).topViewController as ComposeViewController
        
        vc.replyUserName = replyUserName
        vc.replyStatusId = replyStatusId
        vc.replyText = replyStatusText
        } else {
            println( segue.identifier )
        }

    }


}
