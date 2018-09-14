//
//  ViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/30/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if (!App.shared.currentUser.isLoggedIn()) {
            self.navigationController?.present(LoginViewController(), animated: true, completion: nil)
        }
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.registerNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private API
    private func setup() {
        self.title = App.shared.currentUser.displayName

    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(notification_userLoggedIn(_:)), name: .userLoggedIn, object: nil)
    }
    

    @objc func notification_userLoggedIn(_ notification:Notification) {
        self.title = App.shared.currentUser.displayName
    }
}

