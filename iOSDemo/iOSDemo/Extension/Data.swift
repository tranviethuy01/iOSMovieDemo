//
//  Data.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

extension Data {
    var jsonString: String? {
        return String.init(data: self, encoding: .utf8)
    }
}
