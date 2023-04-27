//
//  CustomLoadingView.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import UIKit

class CustomLoadingView: UIView {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicatorWrapperView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    static let sharedInstance: CustomLoadingView = {
        struct SingletonWrapper {
            static let singleton = ViewService.viewFrom("CustomLoadingView") as! CustomLoadingView
        }
        return SingletonWrapper.singleton;
    }()
    
    var isShowed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    
    func updateView() {
        frame.size = ViewService.screenSize()
        frame.origin = CGPoint.init(x: 0, y: 0)
        loadingIndicatorWrapperView.frame.size.width = 60
        loadingIndicatorWrapperView.layer.cornerRadius = 10
        loadingIndicatorWrapperView.layer.masksToBounds = true
        loadingIndicatorWrapperView.frame.size.height = 50
        loadingIndicator.frame.size = CGSize.init(width: 37, height: 37)
        loadingIndicatorWrapperView.frame.origin.x = (frame.size.width - loadingIndicatorWrapperView.frame.size.width)/2
        loadingIndicatorWrapperView.frame.origin.y = (frame.size.height - loadingIndicatorWrapperView.frame.size.height)/2
        loadingIndicator.frame.origin.x = (loadingIndicatorWrapperView.frame.size.width - loadingIndicator.frame.size.width)/2
        loadingIndicator.frame.origin.y = (loadingIndicatorWrapperView.frame.size.height - loadingIndicator.frame.size.height)/2
    }
    
    func show() {
        if let window = UIApplication.shared.keyWindow, isShowed == false {
            isHidden = false
            window.addSubview(self)
            window.bringSubviewToFront(self)
            isShowed = true
        }
    }
    func hide() {
        if let _ = superview , isShowed == true{
            isHidden = true
            removeFromSuperview()
            isShowed = false
        }
    }
    
    

    

}
