//
//  NetworkSessionManager.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

class NetworkSessionManager {
    var session: AnyObject!
    init () {
        session = createSession()
    }
    func createSession() -> AnyObject {
        return "Not Implemented" as AnyObject
    }
    
    func currentHeaderForRequest() -> [String: String] {
        let header: [String:String] = [:]
        
        return header
    }
    func createParameters(_ parameters: [String: AnyObject]?) -> [String: AnyObject] {
        var newParamters: [String: AnyObject] = [:]
        if let parameters = parameters {
            let keys = parameters.keys
            for key in keys {
                newParamters.updateValue(parameters[key]!, forKey: key)
            }
        }
        return newParamters
    }
    
}
