//
//  Channel.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/4/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

struct Channel {
    let id: String?
    let name: String
    var creator:String
    var members:Int = 0
    var isPrivate:Bool = false
    
    init(withName name:String, creator:String, isPrivate:Bool) {
        self.name = name
        self.creator = creator
        self.isPrivate = isPrivate
        self.members = 1
        self.id = NSUUID().uuidString
    }
}

extension Channel: LabelSubLabelItemProtocol  {
    var labelText: String {
        get {
            return self.name
        }
    }
    
    var subLabelText: String {
        get {
            return self.creator
        }
    }
    
    var showPrivateIndicator: Bool {
        get {
            return self.isPrivate
        }
    }
    
}


