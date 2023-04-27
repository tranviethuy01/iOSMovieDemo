//
//  ResponseData.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
class ResponseData {
    var code: Int? {
        get {
            return _code
        }
    }
    private var _code: Int
    var value: Any
    var requestInfo: NetworkRequestInfo
    var url: String? {
        get {
            return requestInfo.url
        }
    }
    init(code: Int, value: Any, requestInfo: NetworkRequestInfo) {
        self._code = code
        self.value = value
        self.requestInfo = requestInfo
    }
}
