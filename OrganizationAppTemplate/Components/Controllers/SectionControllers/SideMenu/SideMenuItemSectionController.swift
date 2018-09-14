//
//  SideMenuItemSectionController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/31/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

protocol SideMenuOptionSectionControllerDelegate {
    func didSelectSideMenuOptionItem(item:SideMenuItem)
}

class SideMenuItemSectionController: ListSectionController {
    var delegate:SideMenuOptionSectionControllerDelegate?
    var revealWidth:CGFloat?
    fileprivate var item:SideMenuItem?
    
    // MARK: Initialization
    init(withRevealWidth width:CGFloat, delegate:SideMenuOptionSectionControllerDelegate) {
        self.revealWidth = width
        self.delegate = delegate
    }
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:SideMenuItemCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: SideMenuItemCollectionViewCell.self, for: self, at: index) as! SideMenuItemCollectionViewCell
        
        cell.updateWithRevealWidth(revealWidth: self.revealWidth!, name: self.item?.name, image: self.item?.image)
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? SideMenuItem
    }
    
    override func didSelectItem(at index: Int) {
        
        //if delegate exists and conforms to method
        if let delegateVC = self.delegate {
            delegateVC.didSelectSideMenuOptionItem(item: self.item!)
        }
        
    }
}
