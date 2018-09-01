//
//  SideMenuHeader.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 8/31/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class SideMenuHeader: NSObject {
    var name:String?
    var image:UIImage?
    var version:String?
    
    init?(withName name:String, image:UIImage?, version:String?) {
        self.name = name
        self.image = image
        self.version = version
    }
}

extension SideMenuHeader: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self.name! as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SideMenuHeader else {
            return false
        }
        return self.name == object.name
    }
}
