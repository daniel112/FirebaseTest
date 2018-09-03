//
//  App.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/2/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import FirebaseAuth

class App {
    
    // MARK: - Properties
    static let shared = App()
    
    private var _currentUser:User?
    var currentUser: User {
        get {
            if (_currentUser == nil) {
                let isLoggedIn = UserDefaults.standard.object(forKey: UserDefaultKeys().isLoggedIn) as? Bool ?? false
                if (isLoggedIn) {
                    let user = Auth.auth().currentUser
                    _currentUser = User.init(withName: user!.displayName!, email: user!.email, token: user!.refreshToken)
                    return _currentUser!
                } else {
                    _currentUser = User()
                }
            }
            return _currentUser!
        }
        set(value) {
            _currentUser = value
        }
    }
    
    
    private init() {
    }
    
    
    // MARK: - Private API
    
    // MARK: - Public API
    
}
