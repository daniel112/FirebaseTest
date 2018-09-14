//
//  Message.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/4/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import Foundation
import MessageKit
import CoreLocation

private struct MockLocationItem: LocationItem {
    
    var location: CLLocation
    var size: CGSize
    
    init(location: CLLocation) {
        self.location = location
        self.size = CGSize(width: 240, height: 240)
    }
    
}

private struct MockMediaItem: MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    init(image: UIImage) {
        self.image = image
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage()
    }
    
}

internal struct MockMessage: MessageType {
    
    let id: String?
    var messageId: String {
        return id ?? UUID().uuidString
    }
    let content: String
    var sender: Sender
    var sentDate: Date
    var kind: MessageKind // what is displayed will be stored here
    
    private init(kind: MessageKind, sender: Sender, content:String, messageId: String, date: Date) {
        self.kind = kind
        self.sender = sender
        self.sentDate = date
        self.content = content
        self.id = nil
    }
    
    // TEST INIT
    init(user: User, content: String) {
        //sender = Sender(id: user.uid, displayName: AppSettings.displayName)
        sender = Sender(id: user.token!, displayName: "TEST ACCOUNT")
        self.content = content
        sentDate = Date()
        self.kind = MessageKind.text(content)
        id = "1"
    }
    
    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: MessageKind.text(text), sender: sender, content: text, messageId: messageId, date: date)
    }
    
}

// Need to conform to Comparable/Equatable so we can perform certain array methods
extension MockMessage: Comparable {
    
    static func == (lhs: MockMessage, rhs: MockMessage) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: MockMessage, rhs: MockMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}