//
//  LabelSubLabelSectionController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/3/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

protocol LabelSubLabelItemProtocol {
    var labelText:String { get  }
    var subLabelText:String { get }
    var showPrivateIndicator:Bool { get }
}

protocol LabelSubLabelSectionControllerDelegate {
    func didSelectOptionItem(item:Any)
}

class LabelSubLabelSectionController: ListSectionController {

    // MARK: Properties
    fileprivate var items = [LabelSubLabelItemProtocol]()
    var delegate:LabelSubLabelSectionControllerDelegate?
    
    // MARK: Initialization
    
    
    // MARK: ListSectionController
    override func numberOfItems() -> Int {
        return self.items.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 50)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:LabelSubLabelCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: LabelSubLabelCollectionViewCell.self, for: self, at: index) as! LabelSubLabelCollectionViewCell
        cell.text = self.items[index].labelText
        cell.subText = self.items[index].subLabelText
        cell.showCustomIndicator = self.items[index].showPrivateIndicator
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        let diffableArray:IGListDiffableArray = object as! IGListDiffableArray
        self.items = diffableArray.array as! [LabelSubLabelItemProtocol]
    }
    
    override func didSelectItem(at index: Int) {
        self.delegate?.didSelectOptionItem(item: self.items[index])
    }
}
