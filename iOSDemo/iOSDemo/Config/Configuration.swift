//
//  Configuration.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
/// Here come the configuration for production and development
class Configuration: NSObject {
    private let developmentBaseRequestURL: String = "https://tranhuy.bachkhoasaigon.com/test/api"
    private let productionBaseRequestURL: String = "https://tranhuy.bachkhoasaigon.com/test/api"
    
    var baseRequestURL: String = ""
    override init() {
        #if DEBUG
            baseRequestURL = developmentBaseRequestURL
        #else
            baseRequestURL = productionBaseRequestURL
        #endif
    }
}
