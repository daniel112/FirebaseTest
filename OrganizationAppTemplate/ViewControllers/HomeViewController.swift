//
//  ViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/30/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        if Auth.auth().currentUser != nil {
            if let user = Auth.auth().currentUser {
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                print("\n\n is Logged in", user.displayName!)
            }
            
        } else {
            self.present(LoginViewController(), animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    private func setup() {
        self.view.backgroundColor = UIColor.white
    }
    
    

}

