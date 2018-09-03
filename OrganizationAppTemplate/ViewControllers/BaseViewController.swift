//
//  BaseViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/31/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import SWRevealViewController

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    private func setup() {
        //set menu image
        let menuImage = UIImage(named: "nav_menu")!.withRenderingMode(.alwaysTemplate)

        //set bg color
        view.backgroundColor = UIColor.white

        // Navigation - Status Bar Style
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // Navigation - Menu Button
        if (self.navigationController!.viewControllers[0] == self ) {
            
            let revealController:SWRevealViewController = self.revealViewController()
            revealController.panGestureRecognizer()
            revealController.tapGestureRecognizer()
            let sideMenuButton = UIBarButtonItem(image: menuImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(buttonMenu_touchUpInside(sender:)))
            sideMenuButton.tintColor = UIColor.white
            self.navigationItem.leftBarButtonItem = sideMenuButton
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
    }

    @objc func buttonMenu_touchUpInside(sender: UIBarButtonItem) {
        revealViewController().revealToggle(animated: true)
    }

}
