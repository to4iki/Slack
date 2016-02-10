//
//  SlackTests.swift
//  SlackTests
//
//  Created by to4iki on 2/10/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import XCTest
@testable import Slack

class SlackTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSendMessage() {
        // TODO
    }
    
    func testRequestBodyBuilder() {
        let builder = Slack.RequestBodyBuilder()
        builder.channel("#general").botName("bot").iconEmoji(":ghost:").text("test")
        
        let expectd = ["channel": "#general", "username": "bot", "icon_emoji": ":ghost:", "text": "test"]
        
        XCTAssertEqual(expectd, builder.result())
    }
}
