//
//  DadJokeAPI.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/2/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class DadJokeAPI: AFBaseNetworking {
    
    // MARK: - Properties
    private let baseURL = "https://icanhazdadjoke.com/"
    
    // MARK: - Initialization
    private func customInit() {
        
    }
    override init() {
        super.init()
        self.customInit()
    }
    
    // MARK: - Private API
    
    // MARK: - Public API
    public func getRandomDadJoke(completion:@escaping (DadJoke) -> (), failure: @escaping (String) -> ()) {
        
        request(WithBaseURL: baseURL, method: .get, parameters: nil, headers: nil, resultClass: DadJoke.self, completion: { (result : DadJoke) in
            completion(result)
        }) { (errorMessage) in
            failure(errorMessage)
        }
        

    }
    // MARK: - Delegates
}
