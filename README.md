# Slack

[![Build Status][status-image]][status-url]
[![Carthage compatible][carthage-image]][carthage-url]
[![License][license-image]][license-url]

## Description
Slack WebHooks API Client for Swift.
- [Incoming Webhooks | Slack](https://api.slack.com/incoming-webhooks)

## Requirements
- Swift 2.1 or later
- iOS 8.0 or later

## Installation

#### [Carthage](https://github.com/Carthage/Carthage)

- Insert `github "to4iki/Slack"` to your Cartfile.
- Run `carthage update`.
- Link your app with `Slack.framework` in `Carthage/Checkouts`.

## Usage
Configure  
Set webhook URL string.
```swift
let slack = Slack.sharedInstance
Slack.configure("https://hooks.slack.com/services/<YOUR_WEBHOOK_URL>")
```

Send message
```swift
let builder = Slack.RequestBodyBuilder()
    .channel("#general")
    .botName("skack-webhook-sample")
    .iconEmoji(":ghost:")
    .text(text)

slack.sendMessage(builder.result()) { (data, err) in
    if let d = data, s = NSString(data: d, encoding: NSUTF8StringEncoding) {
        print("sucess: \(s)")
    }

    if let e = err {
        print("error: \(e.localizedDescription): \(e.userInfo)")
    }
}
```

## Author

[to4iki](https://github.com/to4iki)

## Licence

[MIT](http://to4iki.mit-license.org/)

[status-url]: https://travis-ci.org/to4iki/Slack
[status-image]: https://travis-ci.org/to4iki/Slack.svg

[carthage-url]: https://github.com/Carthage/Carthage
[carthage-image]: https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat

[license-url]: http://to4iki.mit-license.org/
[license-image]: http://img.shields.io/badge/license-MIT-brightgreen.svg
