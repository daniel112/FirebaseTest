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
import FBSDKLoginKit

class LoginViewController: UIViewController, FUIAuthDelegate, FBSDKLoginButtonDelegate {

    // MARK: - Properties
    let fbLoginButton:FBSDKLoginButton = FBSDKLoginButton()
    var labelTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Sign In"
        return label
    }()
    
    let activityIndicator:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return activity
    }()
    
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
        self.fbLoginButton.delegate = self
        self.view.addSubview(self.fbLoginButton)
        
        // hack to fix the 28 height default
        // https://stackoverflow.com/questions/42002346/cannot-change-the-height-of-login-button-in-fbsdkloginkit
        for const in self.fbLoginButton.constraints {
            if const.firstAttribute == NSLayoutAttribute.height && const.constant == 28 {
                fbLoginButton.removeConstraint(const)
            }
        }
        
        // indicator
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        // title
        self.view.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        // fb button
        self.fbLoginButton.snp.makeConstraints({ (make) in
            //make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(350)
        })

    }
    
    private func data() {

    }

    private func defaultAuthVC() {
        // Not currently used
        let authUI = FUIAuth.defaultAuthUI()
        authUI!.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth()
        ]
        authUI!.providers = providers
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
    
    // MARK: FBSDKLoginButtonDelegate
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        // activity indicator
        self.activityIndicator.startAnimating()
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name"]).start { (connection, result, error) in
            if (error != nil) {
                // try get user info
                self.activityIndicator.startAnimating()
                print(error.debugDescription)
            } else {
                // try get user info
                let accessToken = FBSDKAccessToken.current()
                guard let accessTokenString = accessToken?.tokenString else { return }
                let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
                
                Auth.auth().signInAndRetrieveData(with: credentials, completion: { (user, error) in
                    self.activityIndicator.stopAnimating()
                    if error != nil {
                        print("Something went wrong with our FB user: ", error ?? "")
                        return
                    }
                    // save user info
                    // TODO: can probably clean up this into the shared method
                    let currentUser = User.init(withName: (user?.user.displayName!)!, email: user?.user.email, token: user?.user.refreshToken)
                    App.shared.currentUser = currentUser!
                    UserDefaults.standard.set(true, forKey: UserDefaultKeys().isLoggedIn)
                    NotificationCenter.default.post(name: .userLoggedIn, object: nil)
                    self.dismiss(animated: true, completion: nil)

                })


            }
        }
    }
    
    
}
