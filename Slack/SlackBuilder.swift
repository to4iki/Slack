//
//  SlackRequestBuilder.swift
//  Slack
//
//  Created by to4iki on 2/17/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

public protocol SlackBuilder {
    
    typealias Dest
    
    static func build(builder: Self -> Void) -> Dest
    
    func toParameters() -> Slack.Parameters
}

extension Slack {
    
    /// A normal(base) request parameters.
    public class Message: SlackBuilder {
        
        public typealias Dest = Message
        
        private var channel: String?
        
        private var botName: String?
        
        private var iconEmoji: String?
        
        private var iconUrl: String?
        
        private var text: String?
        
        private var attachments: [Attachment]?
        
        public static func build(builder: Message -> Void) -> Dest {
            let body = Message()
            builder(body)
            return body
        }
        
        /// Override incoming webhooks output to a default channel.
        public func channel(channel: String) -> Self {
            self.channel = channel
            return self
        }
        
        /// Override incoming webhooks output to a default username(botname).
        public func botName(botName: String) -> Self {
            self.botName = botName
            return self
        }
        
        /// Override incoming webhooks output to a default iconEmoji.
        public func iconEmoji(iconEmoji: String) -> Self {
            self.iconEmoji = iconEmoji
            return self
        }
        
        /// Override incoming webhooks output to a default iconUrl.
        public func iconUrl(iconUrl: String) -> Self {
            self.iconUrl = iconUrl
            return self
        }
        
        /// Multi-line message without special formatting.
        public func text(text: String, linkEnable: Bool = true) -> Self {
            self.text = text
            return self
        }
        
        /// Advanced message formatting.
        public func attachment(attachments: [Attachment]) -> Self {
            self.attachments = attachments
            return self
        }
        
        public func toParameters() -> Parameters {
            var parameters: Slack.Parameters = [:]
            
            if let channel = channel {
                parameters["channel"] = channel
            }
            
            if let botName = botName {
                parameters["username"] = botName
            }
            
            if let iconEmoji = iconEmoji {
                parameters["icon_emoji"] = iconEmoji
            }
            
            if let iconUrl = iconUrl {
                parameters["icon_url"] = iconUrl
            }
            if let text = text {
                parameters["text"] = text
                parameters["link_names"] = 1
            }
            
            if let attachments = attachments {
                parameters["attachments"] = attachments.map { $0.toParameters() }
            }
            
            return parameters
        }
    }
}

extension Slack {
    
    /// It is possible to create more richly-formatted messages.
    public class Attachment: SlackBuilder {
        
        public typealias Dest = Attachment
        
        private var fallback: String?
        
        private var color: String?
        
        private var pretext: String?
        
        private var author: Author?
        
        private var title: Title?
        
        private var text: String?
        
        private var imageUrl: String?
        
        private var thumbUrl: String?
        
        private var tableMessages: [TableMessage]?
        
        public static func build(builder: Attachment -> Void) -> Dest {
            let attachment = Attachment()
            builder(attachment)
            return attachment
        }
        
        /// A plain-text summary of the attachment.
        public func fallback(fallback: String) -> Self {
            self.fallback = fallback
            return self
        }
        
        /// A value that can either be one of good, warning, danger.
        public func color(color: Color) -> Self {
            self.color = color.rawValue
            return self
        }
        
        /// Any hex color code.
        public func color(colorCode: String) -> Self {
            self.color = colorCode
            return self
        }
        
        /// A text that appears above the message attachment block.
        public func pretext(pretext: String) -> Self {
            self.pretext = pretext
            return self
        }
        
        /// Display a small section at the top of a message attachment.
        public func author(author: Author) -> Self {
            self.author = author
            return self
        }
        
        /// The title is displayed as larger, bold text near the top of a message attachment.
        public func title(title: Title) -> Self {
            self.title = title
            return self
        }
        
        /// Main text in a message attachment,
        public func text(text: String) -> Self {
            self.text = text
            return self
        }
        
        /// A valid URL to an image file that will be displayed inside a message attachment.
        public func imageUrl(imageUrl: String) -> Self {
            self.imageUrl = imageUrl
            return self
        }
        
        /// A valid URL to an image file that will be displayed as a thumbnail on the right side of a message attachment.
        public func thumbUrl(thumbUrl: String) -> Self {
            self.thumbUrl = thumbUrl
            return self
        }
        
        /// TableMessages are defined as an array.
        /// Displayed in a table inside the message attachment.
        public func tableMessages(tableMessages: [TableMessage]) -> Self {
            self.tableMessages = tableMessages
            return self
        }
        
        public func toParameters() -> Slack.Parameters {
            var parameters: Slack.Parameters = [:]
            
            if let fallback = fallback {
                parameters["fallback"] = fallback
            }
            
            if let color = color {
                parameters["color"] = color
            }
            
            if let pretext = pretext {
                parameters["pretext"] = pretext
            }
            
            if let author = author {
                parameters["author_name"] = author.name
                
                if let link = author.link {
                    parameters["author_link"] = link
                }
                
                if let icon = author.icon {
                    parameters["author_icon"] = icon
                }
            }
            
            if let title = title {
                parameters["title"] = title.text
                
                if let link = title.link {
                    parameters["title_link"] = link
                }
            }
            
            if let text = text {
                parameters["text"] = text
            }
            
            if let imageUrl = imageUrl {
                parameters["image_url"] = imageUrl
            }
            
            if let thumbUrl = thumbUrl {
                parameters["thumb_url"] = thumbUrl
            }
            
            if let tableMessages = tableMessages {
                parameters["fields"] = tableMessages.map { $0.toParameters() }
            }
            
            return parameters
        }
    }
}

// MARK: Attachment Family

extension Slack {
    
    /// This value is used to color the border along the left side of the message attachment.
    public enum Color: String {
        case Good = "good"
        case Warning = "warning"
        case Danger = "danger"
    }
    
    /// Display a small section at the top of a message attachment.
    public struct Author {
        
        /// Display the author's name.
        public let name: String
        
        /// A valid URL that will hyperlink, Will only work if name is present.
        public let link: String?
        
        /// A valid URL that displays a small 16x16px image, Will only work if name is present.
        public let icon: String?
        
        public init(name: String, link: String? = nil, icon: String? = nil) {
            self.name = name
            self.link = link
            self.icon = icon
        }
    }
    
    /// Larger, bold text near the top of a message attachment.
    public struct Title {
        
        /// Title value
        public let text: String
        
        /// Text will be hyperlinked.
        public let link: String?
        
        public init(text: String, link: String?) {
            self.text = text
            self.link = link
        }
    }
    
    /// A table inside the message attachment.
    public struct TableMessage {
        
        /// A bold heading above the value text.
        public let title: String
        
        /// A text value of the field.
        public let value: String
        
        /// An optional flag indicating 
        // whether the value is short enough to be displayed side-by-side with other values.
        public let short: Bool
        
        public init(title: String, value: String, short: Bool = true) {
            self.title = title
            self.value = value
            self.short = short
        }
        
        func toParameters() -> Slack.Parameters {
            return ["title": title, "value": value, "short": short]
        }
    }
}