//
//  Movie.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import Alamofire

/**
 Subscribe to these status to know network status
 */
enum NetworkReachableStatus: String {
    /**
     Subscribe to these status to know network status
     */
    case wifi = "Reachable.Wifi"
    /**
     Subscribe to these status to know network status
     */
    case cellular = "Reachable.Cellular"
    /**
     Subscribe to these status to know network status
     */
    case notReachable = "Reachable.notReachable"
    /**
     Subscribe to these status to know network status
     */
    case unknown = "Reachable.unknown"
}
class AlamofireSessionManager:  NetworkSessionManager {
    override func createSession() -> AnyObject {
        let sessionManager = AF
        sessionManager.session.configuration.httpAdditionalHeaders = self.currentHeaderForRequest()
        sessionManager.session.configuration.timeoutIntervalForRequest = 60
        sessionManager.session.configuration.allowsCellularAccess = true
        sessionManager.session.configuration.httpMaximumConnectionsPerHost = 120
        return sessionManager
    }
    override func currentHeaderForRequest() -> [String : String] {
        return super.currentHeaderForRequest()
    }
    
}
class AlamofireAPIWrapper: NetworkWrapper {
    static let reachabilityManager = NetworkReachabilityManager.init(host: "www.apple.com")
    
    func cancelRequestOfURL(urlString: String) {
        let session = sessionManager.session as! Session
        session.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            dataTasks.forEach({ (dataTask) in
                if let request = dataTask.originalRequest, let url = request.url, url.absoluteString == urlString  {
                    dataTask.cancel()
                }
            })
            uploadTasks.forEach({ (uploadTask) in
                if let request = uploadTask.originalRequest, let url = request.url, url.absoluteString == urlString  {
                    uploadTask.cancel()
                }
            })
            downloadTasks.forEach({ (downloadTask) in
                if let request = downloadTask.originalRequest, let url = request.url, url.absoluteString == urlString  {
                    downloadTask.cancel()
                }
            })
        }
    }
    func cancelRequestContainURL(urlString: String) {
        let session = sessionManager.session as! Session
        session.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            dataTasks.forEach({ (dataTask) in
                if let request = dataTask.originalRequest, let url = request.url, url.absoluteString.contains(urlString)  {
                    dataTask.cancel()
                }
            })
            uploadTasks.forEach({ (uploadTask) in
                if let request = uploadTask.originalRequest, let url = request.url, url.absoluteString.contains(urlString)  {
                    uploadTask.cancel()
                }
            })
            downloadTasks.forEach({ (downloadTask) in
                if let request = downloadTask.originalRequest, let url = request.url, url.absoluteString.contains(urlString)  {
                    downloadTask.cancel()
                }
            })
        }
    }
    class func initReachability() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            let nc = NotificationCenter.default
            switch status {
            case .unknown:
                nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.unknown.rawValue),
                        object: nil,
                        userInfo: nil)
            case .notReachable:
                nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.notReachable.rawValue),
                        object: nil,
                        userInfo: nil)
            case .reachable(let connectionType):
                switch connectionType {
                case .ethernetOrWiFi:
                    nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.wifi.rawValue),
                            object: nil,
                            userInfo: nil)
                case .cellular:
                    nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.cellular.rawValue),
                            object: nil,
                            userInfo: nil)
                }
            }
                
        })
    }
    var sessionManager: NetworkSessionManager = AlamofireSessionManager.init()
    var delegate: NetworkWrapperDelegate?
    func request(requestType: RequestTaskType, requestURLString: String, parameters: [String : AnyObject]?, additionalHeaders: [String : String]?, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler) {
        let session = sessionManager.session as! Session
        let headers: HTTPHeaders? = additionalHeaders != nil ? HTTPHeaders.init(additionalHeaders!) : nil
        switch requestType {
        case .get:
            let request = session.request(requestURLString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            let requestInfo = NetworkRequestInfo.init(url: requestURLString,
                                                      method: requestType,
                                                      headers: additionalHeaders,
                                                      queryParam: parameters,
                                                      cURL: request.cURLDescription,
                                                      isForAuthenticate: forAuthenticate)
            
            request.responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: { [weak self] response in
                requestInfo.responseTime = Date()
                requestInfo.cURL = request.cURLDescription
                if let weakSelf = self {
                    weakSelf.completionHandle(response: response, requestInfo: requestInfo, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
        case .post:
            let request = session.request(requestURLString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            let requestInfo = NetworkRequestInfo.init(url: requestURLString,
                                                      method: requestType,
                                                      headers: additionalHeaders,
                                                      requestBody: parameters,
                                                      cURL: request.cURLDescription,
                                                      isForAuthenticate: forAuthenticate)
            
            request.responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: {[weak self] response in
                requestInfo.responseTime = Date()
                requestInfo.cURL = request.cURLDescription
                if let weakSelf = self {
                    weakSelf.completionHandle(response: response, requestInfo: requestInfo, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
            
        case .put:
            let request = session.request(requestURLString, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            let requestInfo = NetworkRequestInfo.init(url: requestURLString,
                                                      method: requestType,
                                                      headers: additionalHeaders,
                                                      requestBody: parameters,
                                                      cURL: request.cURLDescription,
                                                      isForAuthenticate: forAuthenticate)
            
            request.responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: { [weak self] response in
                requestInfo.responseTime = Date()
                requestInfo.cURL = request.cURLDescription
                if let weakSelf = self {
                    weakSelf.completionHandle(response: response, requestInfo: requestInfo, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
        case .delete:
            let request = session.request(requestURLString, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            let requestInfo = NetworkRequestInfo.init(url: requestURLString,
                                                      method: requestType,
                                                      headers: additionalHeaders,
                                                      requestBody: parameters,
                                                      cURL: request.cURLDescription,
                                                      isForAuthenticate: forAuthenticate)
            
            request.responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: { [weak self] response in
                requestInfo.responseTime = Date()
                requestInfo.cURL = request.cURLDescription
                if let weakSelf = self {
                    weakSelf.completionHandle(response: response, requestInfo: requestInfo, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
        }
    }
    
    func download(requestURLString: String, parameters: [String : AnyObject]?, additionalHeaders: [String : String]?, dataType: DataType, completionHandler: @escaping NetworkCompletionHandler) {
        let session = sessionManager.session as! Session
        let headers: HTTPHeaders? = additionalHeaders != nil ? HTTPHeaders.init(additionalHeaders!) : nil
        let request = session.request(requestURLString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        let requestInfo = NetworkRequestInfo.init(url: requestURLString, method: .get, headers: additionalHeaders, queryParam: parameters, cURL: request.cURLDescription)
        request.response(completionHandler: { [weak self] response in
            requestInfo.responseTime = Date()
            requestInfo.cURL = request.cURLDescription
            if let weakSelf = self {
                weakSelf.completionHandleData(response: response, requestInfo: requestInfo, dataType: dataType, completionHandler: completionHandler)
            }
        })
    }
    
    func upload(requestURLString: String, parameters: [String : AnyObject]?, imagePathInfos: [[String : String]], additionalHeaders: [String : String]?, method: RequestTaskType, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler) {
        let session = sessionManager.session as! Session
        var convertedMethod: HTTPMethod = .post
        switch method {
        case .get:
            convertedMethod = .get
        case .post:
            convertedMethod = .post
        case .delete:
            convertedMethod = .delete
        case .put:
            convertedMethod = .put
        }
        
        let headers: HTTPHeaders? = additionalHeaders != nil ? HTTPHeaders.init(additionalHeaders!) : nil
        let request = session.upload(multipartFormData: { multipartFormData in
            if let parameters = parameters {
                for (key,value) in parameters{
                    if let value = value as? String {
                        if let data = value.data(using: String.Encoding.utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                    else if let value = value as? Dictionary<String, AnyObject> {
                        let data = NSKeyedArchiver.archivedData(withRootObject: value)
                        multipartFormData.append(data, withName: key)
                    }
                    else  {
                        let value = String.init(describing: value)
                        if let data = value.data(using: String.Encoding.utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                }
            }
            
            self.addImageToMultipartFormData(multipartFormData: multipartFormData, imagePathInfos: imagePathInfos)
        },
                       to: requestURLString,
                       usingThreshold: UInt64(),
                       method: convertedMethod,
                       headers: headers,
                       requestModifier: nil)
        
        let requestInfo = NetworkRequestInfo.init(url: requestURLString, method: method, headers: additionalHeaders, cURL: request.cURLDescription())
        
        request.responseString { [weak self] response in
            requestInfo.responseTime = Date()
            requestInfo.cURL = request.cURLDescription
            if let weakSelf = self {
                weakSelf.completionHandle(response: response,
                                          requestInfo: requestInfo,
                                          forAuthenticate: false,
                                          completionHandler: completionHandler)
            }
        }
    }
    
    func addImageToMultipartFormData(multipartFormData: Any, imagePathInfos: [[String : String]]) {
        for info in imagePathInfos {
            if let key = info["key"], let path = info["path"] {
                if path.count > 0 {
                    let url = URL(fileURLWithPath: path)
                    var fileName = "imageName"
                    var mimeType = "image/jpeg"
                    if let name = info["fileName"]  {
                        fileName = name
                    }
                    if let type = info["mimeType"] {
                        mimeType = type
                    }
                    let multipartFormData = multipartFormData as! MultipartFormData
                    multipartFormData.append(url, withName: key, fileName: fileName, mimeType: mimeType)
                    
                    
                }
            }
        }
    }
    
    func completionHandle( response: AFDataResponse<String>, requestInfo: NetworkRequestInfo, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = response.request, let url = request.url {
            requestInfo.url = url.absoluteString
        }
        if let code = response.response?.statusCode {
            if code >= 200 && code <= 300 {
                let responseData = ResponseData.init(code: code, value: "", requestInfo: requestInfo)
                switch response.result {
                case .success(let responseStr):
                    if let convertedValue = NetworkManagerUtilities.convertValue(value: responseStr) {
                        responseData.value = convertedValue
                    }
                    else {
                        responseData.value = responseStr
                    }
                case .failure(let error):
                    responseData.value = error.localizedDescription
                }
                
                if let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.prehandleResponsePackage(responseData, forAuthenticate: forAuthenticate)
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(nil, responseData)
                }
                return
            }
            else {
                var isSpecificError = false
                if let delegate = self.delegate {
                    isSpecificError = delegate.handleSpecificError(code: code)
                }
                if isSpecificError == false{
                    let errorData = ErrorData.init(code: code, value: "Something's wrong", requestInfo: requestInfo)
                    switch response.result {
                    case .success(let responseStr):
                        if let convertedValue = NetworkManagerUtilities.convertValue(value: responseStr) {
                            errorData.value = convertedValue
                        }
                        else {
                            errorData.value = responseStr
                        }
                    case .failure(let error):
                        errorData.value = error.localizedDescription
                    }
                    DispatchQueue.main.async {
                        completionHandler(errorData, nil)
                    }
                }
                return
            }
        }
        else {
            let errorData = ErrorData.init(code: 9999, value: "Somethings went wrong", requestInfo: requestInfo)
            DispatchQueue.main.async {
                completionHandler(errorData, nil)
            }
            return
        }
    }
    
    func completionHandleData(response: Any, requestInfo: NetworkRequestInfo, dataType: DataType, completionHandler: @escaping NetworkCompletionHandler) {
        if let response = response as? AFDataResponse<Data?> {
            if let code = response.response?.statusCode {
                if code >= 200 && code <= 300 {
                    let responseData = ResponseData.init(code: code, value: "", requestInfo: requestInfo)
                    switch response.result {
                    case .success(let data):
                        if let data = data {
                            switch dataType {
                            case .data:
                                responseData.value = data
                            case .image:
                                if let image = UIImage(data: data) {
                                    responseData.value = image
                                }
                            case .string:
                                if let str = String.init(data: data, encoding: .utf8) {
                                    responseData.value = str
                                }
                            }
                        }
                    case .failure(let error):
                        responseData.value = error.localizedDescription
                    }
                    DispatchQueue.main.async {
                        completionHandler(nil, responseData)
                    }
                    return
                }
                else {
                    let errorData = ErrorData.init(code: code, value: "Something's wrong", requestInfo: requestInfo)
                    switch response.result {
                    case .success(let data):
                        if let data = data {
                            errorData.value = data
                            
                        }
                    case .failure(let error):
                        errorData.value = error.localizedDescription
                    }
                    DispatchQueue.main.async {
                        completionHandler(errorData, nil)
                    }
                    return
                }
            }
            else {
                let errorData = ErrorData.init(code: 9999, value: "Somethings went wrong", requestInfo: requestInfo)
                DispatchQueue.main.async {
                    completionHandler(errorData, nil)
                }
                return
            }
        }
    }
    
}

extension DataRequest {
    var cURLDescription: String {
        return cURLDescription()
    }
}

extension DownloadRequest {
    var cURLDescription: String {
        return cURLDescription()
    }
}
