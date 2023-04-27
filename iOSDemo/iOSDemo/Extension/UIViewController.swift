//
//  UIViewController.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import UIKit
extension UIViewController {
    func presentOverContext(_ viewController: UIViewController, animated: Bool, completion: (()->())?) {
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        if let tabBarController = tabBarController {
            tabBarController.present(viewController, animated: animated, completion: completion)
        }
        else if let navigationController = navigationController {
            navigationController.present(viewController, animated: animated, completion: completion)
        }
        else {
            present(viewController, animated: animated, completion: completion)
        }
        
    }
    
    func customPresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: true, completion: nil)
    }
}
