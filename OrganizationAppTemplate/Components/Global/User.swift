//
//  User.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/31/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class User {
    let displayName: String
    let email: String
    var token: Int
    
    init(displayName: String, email: String, token: Int) {
        self.displayName = displayName
        self.email = email
        self.token = token
    }
}
