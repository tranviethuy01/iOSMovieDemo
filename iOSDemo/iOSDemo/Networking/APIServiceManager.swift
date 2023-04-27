//
//  Movie.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import Alamofire
import ObjectMapper
enum RequestType {
    case get
    case post
    case put
    case delete
    case uploadData
    case downloadData
}
class APIServiceManager: NSObject {
    /// Store configuration setup
    private let config = Configuration()
    var networkManager: NetworkManager = NetworkManager()
    /// Make APIServcieManager a singleton
    static let sharedInstance: APIServiceManager = {
        var manager = APIServiceManager()
        manager.networkManager.wrapper.delegate = manager
        return manager
    }()
    
    /**
     Method gets the AskTutor base request URL
     - returns: String
     */
    private func getBaseRequestURL() -> String {
        return config.baseRequestURL
    }
    
    func currentRequestURLString(fromEndPoint endPoint: String) -> String {
        return self.getBaseRequestURL() + "/" + endPoint
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
    
    func currentHeaderForRequest(extraHeaders: [String:String]?) -> [String: String] {
        var header: [String:String] = [:]
        if let extraHeaders = extraHeaders {
            header = extraHeaders
        }
        header[Constant.kXDemoAppClient] = Constant.appClientId
        return header
    }
}

// MARK: - NetworkWrapperDelegate
extension APIServiceManager: NetworkWrapperDelegate {
    func prehandleResponsePackage(_ responsePackage: ResponseData, forAuthenticate: Bool) {
        print("prehandleResponsePackage")
    }
    
    func handleSpecificError(code: Int) -> Bool {
        return false
    }
}
// MARK: - API Service true section
extension APIServiceManager {
    func getMovieList(completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentRequestURLString(fromEndPoint: "quicksuitetrading/movies/movies.php")
        let parameters = createParameters(nil)
        let headers = currentHeaderForRequest(extraHeaders: nil)
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: parameters, additionalHeaders: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func getMovie(movieId: Int, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentRequestURLString(fromEndPoint: "quicksuitetrading/movie/\(movieId).php")
        let parameters = createParameters(nil)
        let headers = currentHeaderForRequest(extraHeaders: nil)
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: parameters, additionalHeaders: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func addToWatchList(movieId: Int, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentRequestURLString(fromEndPoint: "quicksuitetrading/movie/\(movieId)/add-to-watch-list")
        let parameters = createParameters(nil)
        let headers = currentHeaderForRequest(extraHeaders: nil)
        networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: parameters, additionalHeaders: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
}


