//
//  DadJoke.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/1/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import ObjectMapper

class DadJoke: NSObject, Mappable {

    var joke:String?
    var id:String?
    
    // MARK: Mappable
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        joke <- map["joke"]
        id <- map["id"]
    }
}
