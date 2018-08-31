//
//  LoginViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/30/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        self.data()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    private func setup() {
        
    }
    
    private func data() {
        //FirebaseApp.configure()
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI!.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
            ]
        authUI!.providers = providers
        
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: false, completion: nil)
    }


    // MARK: Delegate
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
    }
}
