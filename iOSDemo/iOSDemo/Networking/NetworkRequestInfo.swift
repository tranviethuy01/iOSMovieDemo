//
//  NetworkRequestInfo.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

class NetworkRequestInfo {
    var url: String
    var method: RequestTaskType
    var headers: [String: String]?
    var queryParam: [String: Any]?
    var requestBody: [String: Any]?
    
    var isForAuthenticate: Bool
    /// cURL from requested request
    var cURL: String?
    var requestTime: Date
    var responseTime: Date?
    var responseHeaders: [String: String]?
    
    var downloadDestinationURL: URL?
    
    var latency: TimeInterval {
        get {
            if let responseTime = responseTime {
                return responseTime.timeIntervalSince(requestTime)
            }
            return 0
        }
    }
    
    init (url: String = "https://",
          method: RequestTaskType = .get,
          headers: [String: String]? = nil,
          queryParam: [String: Any]? = nil,
          requestBody: [String: Any]? = nil,
          cURL: String? = nil,
          requestTime: Date = Date(),
          responseTime: Date? = nil,
          responseHeaders: [String: String]? = nil,
          downloadDestinationURL: URL? = nil,
          isForAuthenticate: Bool = false) {
        self.url = url
        self.method = method
        self.headers = headers
        self.queryParam = queryParam
        self.requestBody = requestBody
        self.cURL = cURL
        self.requestTime = requestTime
        self.responseTime = responseTime
        self.responseHeaders = responseHeaders
        self.downloadDestinationURL = downloadDestinationURL
        self.isForAuthenticate = isForAuthenticate
    }
    
    convenience init(networkRequestInfo: NetworkRequestInfo) {
        self.init(url: networkRequestInfo.url,
                  method: networkRequestInfo.method,
                  headers: networkRequestInfo.headers,
                  queryParam: networkRequestInfo.queryParam,
                  requestBody: networkRequestInfo.requestBody,
                  cURL: networkRequestInfo.cURL,
                  requestTime: networkRequestInfo.requestTime,
                  responseTime: networkRequestInfo.responseTime,
                  responseHeaders: networkRequestInfo.responseHeaders,
                  downloadDestinationURL: networkRequestInfo.downloadDestinationURL,
                  isForAuthenticate: networkRequestInfo.isForAuthenticate)
    }
    
    func copy() -> NetworkRequestInfo {
        return NetworkRequestInfo.init(networkRequestInfo: self)
    }
}

extension NetworkRequestInfo {
//    var getCURLLink: String? {
//        get {
//            guard let cURL = cURL else {
//                return ""
//            }
//            
//            guard Configuration.init().isLogWithGetCurl else {
//                return ""
//            }
//            
//            //remove $ from Alamofire's 2 first prefix debugDescription Output
//            guard cURL.count >= 2 else {
//                return ""
//            }
//            let index = cURL.index(cURL.startIndex, offsetBy: 2)
//            let subCurl = cURL.suffix(from: index)
//            guard let data = "\(subCurl)".data(using: .utf8) else { return ""}
//            let base64Curl = data.base64EncodedString(options: [])
//            return "https://www.getcurl.app/#body=\(base64Curl)"
//        }
//    }
}
