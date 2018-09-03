//
//  AFBaseNetworking.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/2/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class AFBaseNetworking: NSObject {
    
    // MARK: - Properties
    
    var baseHeader: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    // MARK: - Initialization
    private func customInit() {
        
    }
    override init() {
        super.init()
        self.customInit()
    }
    
    // MARK: - Private API
    
    // MARK: - Public API
    func request<T:Mappable>(WithBaseURL url:String, method:HTTPMethod, parameters:[String:Any]?, headers:[String: String]?, resultClass:T.Type, completion:@escaping (T) -> (), failure: @escaping (String) -> ()) {
        if let additionalHeaders = headers {
            baseHeader.merge(additionalHeaders) { (current, _) in current }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: self.baseHeader).responseObject { (response : DataResponse<T>) in
            if (response.result.isSuccess) {
                completion(response.result.value!)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            } else {
                failure("\n\nError in request")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        }
    }
    // MARK: - Delegates
    
}
