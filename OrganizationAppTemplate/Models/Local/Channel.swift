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
    
    init(withID id: String , name:String, creator:String, members:Int, isPrivate:Bool) {
        self.name = name
        self.creator = creator
        self.isPrivate = isPrivate
        self.members = members
        self.id = id
    }
    
    init(withName name:String, creator:String, isPrivate:Bool) {
        self.init(withID: NSUUID().uuidString, name: name, creator: creator, members: 1, isPrivate: isPrivate)
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


