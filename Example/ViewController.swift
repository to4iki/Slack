//
//  ViewController.swift
//  Example
//
//  Created by to4iki on 2/11/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import Slack

final class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    private let slack = Slack.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func postMessage(sender: UIButton) {
        guard let text = textField.text where text != "" else {
            print("text is empty.")
            return
        }
        
        // sample parameter.
        let params = Slack.RequestBodyBuilder()
            .channel("#general")
            .botName("skack-webhook-sample")
            .iconEmoji(":ghost:")
            .text(text)
            .result()
        
        slack.sendMessage(params) { (data, err) -> Void in
            if let d = data, s = NSString(data: d, encoding: NSUTF8StringEncoding) {
                print(s)
            }
            
            if let e = err {
                print("error: \(e.localizedDescription): \(e.userInfo)")
            }
        }
    }
}

