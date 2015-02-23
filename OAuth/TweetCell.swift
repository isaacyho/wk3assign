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
    @IBOutlet weak var mainImage: UIImageView!
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
        
        mainImage.setImageWithURL( NSURL( string: tweet.user!.profileImageUrl! ) )
        message.preferredMaxLayoutWidth = message.frame.size.width
        timeLabel.text = tweet.getElapsedTime()
        
        self.tweet = tweet

    
    }

}
