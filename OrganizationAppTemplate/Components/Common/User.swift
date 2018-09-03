//
//  User.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/31/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import FirebaseAuth

class User {
    
    let displayName: String?
    let email: String?
    var token: String?
    
    init?(withName name:String, email:String?, token:String?) {
        self.displayName = name
        self.email = email
        self.token = token
    }
    
    init() {
       self.displayName = ""
        self.email = ""
        self.token = ""
    }
    
    // MARK: - Private API
    
    // MARK: - Public API
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
