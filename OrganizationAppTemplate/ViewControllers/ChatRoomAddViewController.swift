//
//  ChatRoomAddViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/3/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class ChatRoomAddViewController: UIViewController {

    // MARK: - Properties
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
        label.text = "Create New Room"
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    private var buttonCancel:UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: UIControlState.normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonCancel_touchUpInside), for: .touchUpInside)
        return button
    }()
    
    private var buttonCreate:UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: UIControlState.normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonCreate_touchUpInside), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)        
        self.initialize()
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private API
    private func setup() {
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
        
        // textFieldname
        
        // dropdown private
        
        // create button
        self.container.addSubview(self.buttonCreate)
        self.buttonCreate.snp.makeConstraints { (make) in
            make.bottom.left.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(150)
            //make.top.equalTo(self.labelMessage.snp.bottom)
        }
        
        // cancel button
        self.container.addSubview(self.buttonCancel)
        self.buttonCancel.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    
    // MARK: UIResponder
    @objc func buttonCreate_touchUpInside(sender:UIButton!) {

    }
    @objc func buttonCancel_touchUpInside(sender:UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Public API
    
    // MARK: - Delegates


}
