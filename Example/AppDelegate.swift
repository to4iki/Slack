//
//  AppDelegate.swift
//  Example
//
//  Created by to4iki on 2/11/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import Slack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        configure()
        return true
    }
    
    func configure() {
        Slack.configure("https://hooks.slack.com/services/<YOUR_WEBHOOK_URL>")
    }
}
