//
//  SideMenuHeaderCollectionViewCell.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/31/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class SideMenuHeaderCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    // Data
    public var name:String? {
        get { return self.label.text }
        set { self.label.text = newValue }
    }
    public var version:String? {
        get { return self.labelVersion.text }
        set { self.labelVersion.text = newValue }
    }
    public var image:UIImage? {
        get { return self.imageView.image }
        set { self.imageView.image = newValue?.withRenderingMode(.alwaysTemplate) }
    }
    fileprivate var revealWidth:CGFloat?

    // UI
    fileprivate var wrapper:UIView = {
        let wrapper = UIView()
        return wrapper
    }()
    lazy private var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    lazy private var labelVersion:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    fileprivate var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private API

    
    // MARK: Public API
    func updateWithRevealWidth(revealWidth:CGFloat, name:String?, version:String?, image:UIImage?) {
        
        self.name = name
        self.version = version
        self.image = image

        if (self.revealWidth != revealWidth) {
            
            self.revealWidth = revealWidth
            
            self.contentView.addSubview(wrapper)
            wrapper.snp.makeConstraints({ (make) in
                make.top.left.equalTo(self.contentView)
                make.width.equalTo(revealWidth)
                make.height.equalTo(self.contentView.frame.height)
            })
            
            // image
            self.wrapper.addSubview(self.imageView)
            self.imageView.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.equalTo(40)
                make.height.equalTo(40)
            })
            // title
            self.wrapper.addSubview(self.label)
            self.label.snp.makeConstraints({ (make) in
                make.top.equalTo(self.imageView.snp.bottom)
                make.centerX.equalToSuperview()
            })
            
            // version
            self.wrapper.addSubview(self.labelVersion)
            self.labelVersion.snp.makeConstraints({ (make) in
                make.top.equalTo(self.label.snp.bottom)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview()
            })
            
        }
    }
    
}
