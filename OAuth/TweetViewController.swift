//
//  TweetViewController.swift
//  OAuth
//
//  Created by Isaac Ho on 2/20/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var replyUserName: String?
    var replyStatusText: String?
    var replyStatusId: String?
    
    var detailsTweetCell: TweetCell?
    
    @IBAction func onRetweet(sender: AnyObject) {
        var s = sender as UIButton
        var cell = s.superview?.superview as UITableViewCell
        var indexPath = tableView.indexPathForCell(cell)
        
        var id = tweets![indexPath!.row].id!
        TwitterClient.sharedInstance.retweet(id)
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        var s = sender as UIButton
        var cell = s.superview?.superview as UITableViewCell
        var indexPath = tableView.indexPathForCell(cell)
        
        var id = tweets![indexPath!.row].id!
        TwitterClient.sharedInstance.favorite(id)
    }
    @IBOutlet weak var replyButton: UIButton!
    var tweets: [Tweet]?
    
    @IBAction func onCompose(sender: AnyObject) {
        performSegueWithIdentifier("composeSegue", sender: nil)
    }
    func setTweets( newTweets: [Tweet] )
    {
        tweets = newTweets
        tableView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( tweets == nil ){
            return 0
        }
        else {
            return tweets!.count
        }
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if ( cell.respondsToSelector("setSeparatorInset:") ) {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if ( cell.respondsToSelector("setLayoutMargins:") ) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.tweetcell") as TweetCell
        cell.initWithTweet( tweets![ indexPath.row ] )
        
        detailsTweetCell = cell
        
        performSegueWithIdentifier("detailsSegue", sender: nil)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.tweetcell") as TweetCell
        cell.initWithTweet( tweets![ indexPath.row ] )
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.fetchHomeTimelineAsync(setTweets)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget( self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    @IBAction func onReply(sender: AnyObject) {
        println("reply")
        var s = sender as UIButton
        var cell = s.superview?.superview as UITableViewCell
        var indexPath = tableView.indexPathForCell(cell)
        
        replyUserName = tweets![indexPath!.row].user!.screenName
        replyStatusId = tweets![indexPath!.row].id!
        replyStatusText = tweets![indexPath!.row].text!
        
        performSegueWithIdentifier("composeSegue", sender: nil)

    }
    
    func onRefresh()
    {
        println( "on refresh" )
        TwitterClient.sharedInstance.fetchHomeTimelineAsync(setTweets)
        self.refreshControl.endRefreshing()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "composeSegue" ) {
            var vc = ( segue.destinationViewController as UINavigationController ).topViewController as ComposeViewController

            vc.replyUserName = replyUserName
            vc.replyStatusId = replyStatusId
            vc.replyText = replyStatusText
        } else if ( segue.identifier == "detailsSegue" ) {
            var vc = ( segue.destinationViewController as UINavigationController ).topViewController as TweetDetailsViewController
            vc.tweetCell = detailsTweetCell

        }
        println("done with segue prep")
    }
    
    @IBAction func sendTweet( segue: UIStoryboardSegue )
    {
        
    }
    @IBAction func cancelTweet( segue: UIStoryboardSegue )
    {
        
    }
    
}
