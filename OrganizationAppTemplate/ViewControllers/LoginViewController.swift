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
    
    // MARK: - Private API
    private func setup() {
        self.view.backgroundColor = UIColor.white
        self.title = "Login"
    }
    
    private func data() {
        let authUI = FUIAuth.defaultAuthUI()

        authUI!.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth()
            ]
        authUI!.providers = providers
        
        // default view TODO: Replace with custom button
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: false, completion: nil)
    }


    // MARK: - Delegate
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if (error != nil) {
            print("\n\nfailed login %@", error.debugDescription)
            self.navigationController?.present(AlertViewController.init(WithTitle: "Error", message: "Error signing in. Try again later"), animated: true, completion: nil)
            
        } else {
            print("successful login")
           if let user = Auth.auth().currentUser {
            let currentUser = User.init(withName: user.displayName!, email: user.email, token: user.refreshToken)
            App.shared.currentUser = currentUser!
            UserDefaults.standard.set(true, forKey: UserDefaultKeys().isLoggedIn)
            }
            self.navigationController?.present(AlertViewController.init(WithTitle: "Login Successful", message: "Logged in as \(App.shared.currentUser.displayName!)"), animated: true, completion: nil)
            // change to Home page
            self.revealViewController().pushFrontViewController(UINavigationController.init(rootViewController: DadJokeViewController()), animated: true)
            
        }
    }
    
    
}
