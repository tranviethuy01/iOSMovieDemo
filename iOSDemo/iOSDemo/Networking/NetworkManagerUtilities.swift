//
//  NetworkManagerUtilities.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import UIKit
final class NetworkManagerUtilities {
    class func convertValue(value: Any) -> Any? {
        if let value = value as? [[String:AnyObject]] {
            return value
        }
        if let value = value as? [String:AnyObject] {
            return value
        }
        if let value = value as? String {
            if let data = value.data(using: String.Encoding.utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: [])
                }
                catch {
                    return ("Error in convert value: \(error.localizedDescription)")
                }
            }
        }
        return nil
    }
    class func getDownloadDestinationPath(url: URL, response: URLResponse) -> URL {
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if let pathComponent = response.suggestedFilename {
            return directoryURL.appendingPathComponent(pathComponent)
        }
        else {
            return directoryURL.appendingPathComponent("imageName.jpg")
        }
    }
    
    class func responseDataAndCodeFrom(destinationURL: URL, code: Int, dataType: DataType, requestInfo: NetworkRequestInfo, completionHandler: @escaping NetworkCompletionHandler) {
        switch dataType {
        case .data:
            do {
                let data = try Data.init(contentsOf: destinationURL, options: Data.ReadingOptions.init(rawValue: 0))
                let responseData = ResponseData.init(code: code, value: data, requestInfo: requestInfo)
                completionHandler(nil, responseData)
                return
            }
            catch {
                
            }
        case .image:
            if let image = UIImage.init(contentsOfFile: destinationURL.absoluteString) {
                let responseData = ResponseData.init(code: code, value: image, requestInfo: requestInfo)
                completionHandler(nil, responseData)
                return
            }
        case .string:
            do {
                let str = try String.init(contentsOfFile: destinationURL.absoluteString)
                let responseData = ResponseData.init(code: code, value: str, requestInfo: requestInfo)
                completionHandler(nil, responseData)
                return
            }
            catch {
                
            }
        }
        let errorData = ErrorData.init(code: 9999, value: "Somethings went wrong")
        completionHandler(errorData, nil)
        return
    }
}
