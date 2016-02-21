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
        
        let msg = Slack.Message.build { m in
            m.channel("#general")
            m.botName("slack-webhook-sample")
            m.iconEmoji(":ghost:")
            m.text(text)
            m.attachment([
                AttachmentSample.groove, AttachmentSample.honeybadger, AttachmentSample.datadog
            ])
        }
        
        slack.sendMessage(msg) { (data, err) -> Void in
            if let d = data, s = NSString(data: d, encoding: NSUTF8StringEncoding) {
                print("success \(s)")
                self.clearText()
            }
            
            if let e = err {
                print("error: \(e.localizedDescription): \(e.userInfo)")
            }
        }
    }
}

extension ViewController {
    
    private func clearText() {
        textField.text = ""
    }
}
