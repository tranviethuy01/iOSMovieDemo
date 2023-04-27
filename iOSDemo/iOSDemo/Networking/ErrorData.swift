//
//  ErrorData.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
class ErrorData {
    var code: Int? {
        get {
            return _code
        }
    }
    private var _code: Int
    var value: Any
    var requestInfo: NetworkRequestInfo
    init(code: Int, value: Any, requestInfo: NetworkRequestInfo = NetworkRequestInfo.init()) {
        self._code = code
        self.value = value
        self.requestInfo = requestInfo
    }
}
