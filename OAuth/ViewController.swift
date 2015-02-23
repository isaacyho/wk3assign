//
//  ViewController.swift
//  OAuth
//
//  Created by Isaac Ho on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Current user: \(User.currentUser)")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogin(sender: AnyObject)
    {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier( "loginSegue", sender: self )
            }
        }
            
   
    }
}

