//
//  ProfileViewController.swift
//  OAuth
//
//  Created by Isaac Ho on 2/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    var dragMenuDelegate: DragMenuDelegate?
    
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    // pan gesture recognized
    @IBAction func onGesture(sender: UIPanGestureRecognizer) {
        if ( sender.state == UIGestureRecognizerState.Began )
        {
            dragMenuDelegate?.didDragMenu()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainImage.setImageWithURL(NSURL(string:user!.profileImageUrl!))
        descrLabel.text = user!.synopsis!
        username.text = user!.screenName!
        fullname.text = user!.name!
        followersLabel.text = "\(user!.followers!) followers"
        followingLabel.text = "\(user!.following!) following"
        tweetsLabel.text = "\(user!.tweets!) tweets"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
