//
//  AlertViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/1/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    // MARK: Properties
    private var customPresentationController:DimPopupPresentationController = {
        let controller = DimPopupPresentationController()
        return controller
    }()

    private var container:UIView = {
        let container = UIView()
        container.backgroundColor = AppTheme().mainColor()
        container.layer.cornerRadius = 5
        return container
    }()
    
    // UI
    private var labelTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    private var labelMessage:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = AppTheme().secondaryColor()
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    private var buttonDismiss:UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: UIControlState.normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(buttonDismiss_touchUpInside), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.initialize()
    }
    
    init(WithTitle title:String, message:String) {
        super.init(nibName: nil, bundle: nil)
        self.initialize()
        self.labelTitle.text = title
        self.labelMessage.text = message
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.transitioningDelegate = self.customPresentationController
    }
    
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
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(self.container)
        self.container.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        })
        
        // title
        self.container.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        // message
        self.container.addSubview(self.labelMessage)
        self.labelMessage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.labelTitle.snp.bottom)
            make.height.equalTo(100)
        }
        
        // button
        self.container.addSubview(self.buttonDismiss)
        self.buttonDismiss.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(self.labelMessage.snp.bottom)
        }
    }
    
    // MARK: UIResponder
    @objc func buttonDismiss_touchUpInside(sender:UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }

}
