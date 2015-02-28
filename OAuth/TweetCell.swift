//
//  TweetCell.swift
//  OAuth
//
//  Created by Isaac Ho on 2/20/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    var tweet: Tweet?
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var mainImage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithTweet( tweet: Tweet ) {
        fullname.text = tweet.user?.name
        username.text = "@\(tweet.user!.screenName!)"
        message.text = tweet.text
        
        let url = NSURL(string: tweet.user!.profileImageUrl!)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        var img = UIImage(data:data!)
        mainImage.setImage(img, forState: UIControlState.Normal)
        
        
        message.preferredMaxLayoutWidth = message.frame.size.width
        timeLabel.text = tweet.getElapsedTime()
        
        self.tweet = tweet

    
    }

}
