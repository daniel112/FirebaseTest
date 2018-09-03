//
//  DadJokeViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/1/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class DadJokeViewController: BaseViewController {

    // MARK: - Properties
     var labelMessage:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var buttonRandom:UIButton = {
        let button = UIButton()
        button.setTitle("Random Joke", for: UIControlState.normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = AppTheme().secondaryColor()
        button.addTarget(self, action: #selector(buttonRandom_touchUpInside), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        self.getRandomJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Private API
    private func setup() {
        
        // message
        self.view.addSubview(self.labelMessage)
        self.labelMessage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
        
        // button
        self.view.addSubview(self.buttonRandom)
        self.buttonRandom.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.labelMessage.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
    }
    
    private func getRandomJoke() {
        weak var weakself = self
        DadJokeAPI().getRandomDadJoke(completion: { (result) in
            if let strongSelf = weakself {
                strongSelf.labelMessage.text = result.joke
            }
        }) { (errorString) in
            self.navigationController?.present(AlertViewController.init(WithTitle: "Error", message: errorString), animated: true, completion: nil)
        }

    }
    // MARK: UIResponder
    @objc func buttonRandom_touchUpInside(sender:UIButton!) {
        self.getRandomJoke()
    }
    
    // MARK: - Public API
    
    // MARK: - Delegates

}
