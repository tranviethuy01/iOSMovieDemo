//
//  Dictionary.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

extension Dictionary {
    var data: Data? {
        get {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                return jsonData
            }
            catch {
                return nil
            }
        }
    }
    
    var jsonString: String? {
        get {
            return data?.jsonString
        }
    }
}
