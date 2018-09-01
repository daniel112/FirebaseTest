//
//  SideMenuHeaderListSectionController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/31/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class SideMenuHeaderSectionController: ListSectionController {

    // MARK: Properties
    fileprivate var headerObject:SideMenuHeader?
    fileprivate var revealWidth:CGFloat?
    
    // MARK: Initialization
    init(withRevealWidth width:CGFloat) {
        self.revealWidth = width
    }
    
    // MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:SideMenuHeaderCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: SideMenuHeaderCollectionViewCell.self, for: self, at: index) as! SideMenuHeaderCollectionViewCell
        
        cell.updateWithRevealWidth(revealWidth: self.revealWidth!, name: self.headerObject!.name, version: self.headerObject!.version, image: self.headerObject!.image)

        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        self.headerObject = object as? SideMenuHeader
    }
    
}
