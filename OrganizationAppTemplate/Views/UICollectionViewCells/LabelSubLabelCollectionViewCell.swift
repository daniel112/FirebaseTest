//
//  LabelSubLabelCollectionViewCell.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/3/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class LabelSubLabelCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    // Data
    public var text:String? {
        get { return self.label.text }
        set { self.label.text = newValue }
    }
    public var subText:String? {
        get { return self.subLabel.text }
        set { self.subLabel.text = "\(newValue!)'s room" }
    }
    private var _showCustomIndicator:Bool = false
    public var showCustomIndicator:Bool {
        get { return _showCustomIndicator }
        set {
            self._showCustomIndicator = newValue
            if (_showCustomIndicator) {
                // TODO: DANIEL UPDATE IMAGE
                self.imageView.image = UIImage.init(named: "")
            } else {
                self.imageView.image = UIImage.init(named: "")
            }    
        }
    }
    
    // UI
    private var separator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    private var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private var subLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private API
    
    private func setup() {
        
        // label
        self.contentView.addSubview(self.label)
        label.snp.makeConstraints({ (make) in
            make.left.top.equalToSuperview().offset(10)
        })
        // sub label
        self.contentView.addSubview(self.subLabel)
        subLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.label.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        })

        // indicator
        
        // separator
        self.contentView.addSubview(self.separator)
        separator.snp.makeConstraints({ (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(1)
        })
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? UIColor.gray : nil
        }
    }
    
    // MARK: Public API
   
}
