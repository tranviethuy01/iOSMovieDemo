//
//  NetworkWrapper.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

protocol NetworkWrapper {
    var sessionManager: NetworkSessionManager {get set}
    var delegate: NetworkWrapperDelegate? {get set}
    func request(requestType: RequestTaskType, requestURLString: String, parameters: [String: AnyObject]?, additionalHeaders: [String: String]?, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler)
    func download(requestURLString: String, parameters: [String: AnyObject]?, additionalHeaders: [String: String]?, dataType: DataType, completionHandler: @escaping NetworkCompletionHandler)
    /// - Image Path Info format [[String: String]]
    /// - Info format:
    /// -       "key": <parameter name - Required Value>,
    /// -       "path": <file path in local - Required Value>,
    /// -       "fileName": <custom file name - Optional Value>,
    /// -       "mimeType": <custom mime type - Optional Value>
    func upload(requestURLString: String, parameters: [String: AnyObject]?, imagePathInfos: [[String: String]], additionalHeaders: [String: String]?, method: RequestTaskType, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler)
    func addImageToMultipartFormData (multipartFormData: Any, imagePathInfos: [[String: String]])
    func cancelRequestOfURL(urlString: String) 
}

protocol NetworkWrapperDelegate {
    func prehandleResponsePackage(_ responsePackage: ResponseData, forAuthenticate: Bool)
    func handleSpecificError(code: Int) -> Bool
}
