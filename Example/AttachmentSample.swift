//
//  AttachmentSample.swift
//  Slack
//
//  Created by to4iki on 2/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import Slack

/// See also
// https://api.slack.com/docs/attachments
struct AttachmentSample {
    
    static var groove: Slack.Attachment {
        return Slack.Attachment.build { (a: Slack.Attachment) in
            a.fallback("New ticket from Andrea Lee - Ticket #1943: Can't rest my password - https://groove.hq/path/to/ticket/1943")
            a.pretext("New ticket from Andrea Lee")
            a.title(Slack.Title(text: "Ticket #1943: Can't reset my passwor", link: "https://groove.hq/path/to/ticket/1943"))
            a.text("Help! I tried to reset my password but nothing happened!")
            a.color("#7CD197")
        }
    }
    
    static var honeybadger: Slack.Attachment {
        return Slack.Attachment.build { (a: Slack.Attachment) in
            a.fallback("ReferenceError - UI is not defined: https://honeybadger.io/path/to/event/")
            a.text("<https://honeybadger.io/path/to/event/|ReferenceError> - UI is not defined")
            a.color("#F35A00")
            a.tableMessages([
                Slack.TableMessage(title: "Project", value: "Awesome Project"),
                Slack.TableMessage(title: "Environment", value: "Production")
            ])
        }
    }
    
    static var datadog: Slack.Attachment {
        return Slack.Attachment.build { (a: Slack.Attachment) in
            a.fallback("Network traffic (kb/s): How does this look? @slack-ops - Sent by Julie Dodd - https://datadog.com/path/to/event")
            a.title(Slack.Title(text: "Network traffic (kb/s)", link: "https://datadog.com/path/to/event"))
            a.text("How does this look? @slack-ops - Sent by Julie Dodd")
            a.imageUrl("https://datadoghq.com/snapshot/path/to/snapshot.png")
            a.color("#764FA5")
        }
    }
}