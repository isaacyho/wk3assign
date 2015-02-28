//
//  MenuViewController.swift
//  OAuth
//
//  Created by Isaac Ho on 2/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func didSelectProfile()
    func didSelectHome()
    func didSelectNotifications()
}


class MenuViewController: UIViewController {
     var delegate: MenuViewControllerDelegate?
    
    @IBAction func onProfile(sender: AnyObject) {
        println( "menu.onProfile" )
        delegate?.didSelectProfile()
    }
    @IBAction func onHome(sender: AnyObject) {
        delegate?.didSelectHome()
    }
    @IBAction func onNotifications(sender: AnyObject) {
        delegate?.didSelectNotifications()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println( "view did appear" )
    }
}