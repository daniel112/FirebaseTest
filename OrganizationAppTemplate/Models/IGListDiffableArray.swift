//
//  IGListDiffableArray.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/3/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class IGListDiffableArray: NSObject, ListDiffable {
    
    // MARK: - Properties
    private var identifier:String?
    public var array = [Any]()
    
    override init() {
        self.identifier = NSUUID().uuidString
    }
    // MARK: - Initialization
    init(withArray array:[Any]) {
        self.array = array
        self.identifier = NSUUID().uuidString
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier! as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.diffIdentifier() as! String == object!.diffIdentifier() as! String
    }
}
