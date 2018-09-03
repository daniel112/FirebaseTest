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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private API
    private func setup() {
        self.view.backgroundColor = UIColor.white

    }
    
    

}

