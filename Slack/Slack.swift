//
//  Slack.swift
//  Slack
//
//  Created by to4iki on 2/10/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

/// Slack WebHooks API Client
public class Slack {
    
    private var hookURLString: String = ""
    
    private lazy var hookURL: NSURL? = NSURL(string: self.hookURLString)
    
    private let request: Request = Request()
    
    /// Singleton Instance
    public static let sharedInstance: Slack = Slack()
    
    private init() {}
}

/// MARK: - Configuration

extension Slack {
    
    /// Configure WebHooks URL
    public static func configure(hookURLString: String) {
        sharedInstance.hookURLString = hookURLString
    }
}

/// MARK: - API Request

extension Slack {
    
    /// Send configurated message.
    public func sendMessage(message: Message, completionHandler: (NSData?, NSError?) -> Void) {
        guard let url = hookURL else { return }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.request.post(url, parameters: message.toParameters(), completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(data, error)
                }
            })
        }
    }
    
    /// Send simple message.
    public func sendSimpleMessage(text: String, completionHandler: (NSData?, NSError?) -> Void) {
        sendMessage(Message.build({ $0.text(text) }), completionHandler: completionHandler)
    }
}

/// MARK: - HTTP Request Wrapper

extension Slack {
    
    /// A parameter dictionary for the request.
    public typealias Parameters = [String: AnyObject]
    
    /// HTTP method
    private enum HTTPMethod: String {
        case POST
    }
    
    private class Request {
        
        /// Session
        let session = NSURLSession.sharedSession()
        
        /// POST
        func post(url: NSURL, parameters: Parameters, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = HTTPMethod.POST.rawValue
            
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.init(rawValue: 2))
            } catch {
                // TODO: Error Handling
                print("NSJSONSerialization Error")
                return
            }
            
            session.dataTaskWithRequest(request, completionHandler: completionHandler).resume()
        }
    }
}
