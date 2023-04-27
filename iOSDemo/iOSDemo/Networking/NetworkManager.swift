//
//  NetworkManager.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

typealias NetworkCompletionHandler = (_ error: ErrorData?, _ response: ResponseData?)->()


enum RequestTaskType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
enum DataType {
    case image
    case data
    case string
}
enum LibType {
    case AFNetwoking
    case Alamofire
}

class NetworkManager {
    var wrapper: NetworkWrapper
    init() {
        wrapper = AlamofireAPIWrapper()
    }
}
