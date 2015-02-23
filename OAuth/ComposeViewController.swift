//
//  ComposeViewController.swift
//  OAuth
//
//  Created by Isaac Ho on 2/20/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var replyToTextView: UITextView!
    var replyUserName: String?
    var replyStatusId: String?
    var replyText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if ( replyText != nil ) { replyToTextView.text = replyText
        }
        
        fullNameLabel.text = User.currentUser?.name
        userNameLabel.text = User.currentUser!.screenName
        
        profileImage.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
    performSegueWithIdentifier("cancelTweet", sender: nil)

    }
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBAction func onSend(sender: AnyObject) {
    performSegueWithIdentifier("sendTweet", sender: nil)

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if ( segue.identifier == "sendTweet" )
        {
            
            var msg = "\(mainTextView.text)"
            if ( replyUserName != nil && replyStatusId != nil ) { msg = "@\(replyUserName!) \(mainTextView.text)"}
            
            TwitterClient.sharedInstance.composeTweet( msg, inReplyToStatusId: replyStatusId)
        }
    }
    
  
}
