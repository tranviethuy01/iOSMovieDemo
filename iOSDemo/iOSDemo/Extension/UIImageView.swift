//
//  UIImageView.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    func downloadImage(from urlStr: String?, placeholderImage: UIImage?, isBlur: Bool = false, completionHandler: ((UIImage?)->())? = nil) {
        if let urlStr = urlStr, let url = URL.init(string: urlStr) {
            kf.setImage(with: url, placeholder: placeholderImage, options: isBlur ? [.processor(BlurImageProcessor.init(blurRadius: 6))] : nil) { results in
                switch results {
                case .success( let imageResult):
                    if let completionHandler = completionHandler {
                        completionHandler(imageResult.image)
                    }
                case .failure(_):
                    if let completionHandler = completionHandler {
                        completionHandler(nil)
                    }
                }
            }
        }
        else {
            let placeholderURL: URL? = nil
            kf.setImage(with: placeholderURL, placeholder: placeholderImage, options: isBlur ? [.processor(BlurImageProcessor.init(blurRadius: 6))] : nil)  { results in
                switch results {
                case .success( let imageResult):
                    if let completionHandler = completionHandler {
                        completionHandler(imageResult.image)
                    }
                case .failure(_):
                    if let completionHandler = completionHandler {
                        completionHandler(nil)
                    }
                }
            }
        }
    }
    
    func downloadImage(from urlStr: String?, placeHolder: String? = nil, isBlur: Bool = false, completionHandler: ((UIImage?)->())? = nil) {
        if let placeholder = placeHolder {
            downloadImage(from: urlStr, placeholderImage: UIImage.init(named: placeholder), isBlur: isBlur, completionHandler: completionHandler)
        }
        else {
            downloadImage(from: urlStr,placeholderImage: nil,isBlur: isBlur, completionHandler: completionHandler)
        }
    }
}
