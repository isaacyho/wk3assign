//
//  MainViewController.swift
//  OAuth
//
//  Created by Isaac Ho on 2/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

protocol DragMenuDelegate {
    func didDragMenu()
}

class MainViewController: UIViewController, MenuViewControllerDelegate, DragMenuDelegate {

    /*
    There is a contentVC and a menuVC.  The contentVC is at z-index 1, menu at z-index 0.  A bool flag menuIsOpen tracks
        the menu's state.  When the menu is opened, the flag is set, and the contentVC's origin gets shifted to the right,
        thus exposing the menu underneath.

    To swap out different views in the contentVC, we simply remove the VC from the parent view, and then insert the new one in,
        right-shifted if the menu is open
    */
    
    required init(coder aDecoder: NSCoder) {
        menuIsOpen = false

        super.init(coder: aDecoder)
    }
    
    var menuVC: MenuViewController?

    var tweetVC: TweetViewController?
    var profileVC: ProfileViewController?
    
    var contentVC: UIViewController? // points to one of the above VC's

    var menuIsOpen: Bool
    
    func didDragMenu() {
        toggleMenu()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TweetViewController") as? TweetViewController
        profileVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as? ProfileViewController

        tweetVC?.dragMenuDelegate = self
        profileVC?.dragMenuDelegate = self
        
        contentVC = tweetVC

        // prepare the menu VC at lowest z-index
        menuVC = self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
        self.view.insertSubview( menuVC!.view, atIndex:0 )
        self.addChildViewController(menuVC!)
        menuVC!.didMoveToParentViewController(self)
        menuVC!.delegate = self
        
        // add content view
        setContentView( contentVC! )
    }
    
    
    func setContentView( vc: UIViewController )
    {
        if ( contentVC != nil )
        {
            contentVC!.view.removeFromSuperview()
            contentVC!.removeFromParentViewController()
        }
        
        self.view.insertSubview( vc.view, atIndex:1 )
        self.addChildViewController(vc)
        vc.didMoveToParentViewController(self)
        contentVC = vc

        if ( menuIsOpen ) {
            self.contentVC!.view.frame.origin.x = self.contentVC!.view.frame.width - 50
        }
        contentVC!.view!.setNeedsDisplay()
    }
    
    func didSelectHome() {
        tweetVC!.showMentionsInsteadOfHome = false
        setContentView( tweetVC! )
        toggleMenu()

    }
    func didSelectProfile() {
        println( "selected profile" )
        profileVC!.user = User.currentUser
        setContentView( profileVC! )
        toggleMenu()
    }
    func didSelectNotifications() {
        println("didSelectNotifications")
        tweetVC!.showMentionsInsteadOfHome = true
        setContentView( tweetVC! )
        toggleMenu()

    }
    // go from open<->closed
    func toggleMenu() {
        if( !menuIsOpen ){
            UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.contentVC!.view.frame.origin.x = self.contentVC!.view.frame.width - 50
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.contentVC!.view.frame.origin.x = 0
                }, completion: {
                    finished in
            })
        }
        menuIsOpen = !menuIsOpen
    }
}