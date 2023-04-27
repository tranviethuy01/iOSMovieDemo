//
//  ViewService.swift
//  iOSDemo
//
//  Created by Viet Huy on 12/3/22.
//
import Foundation
import UIKit
final class ViewService {
    // MARK: Screen size
    class func screenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    // MARK: Storyboard
    /**
     Method returns an instance of the view controller defined by the storyboard Id paramter from the storyboard defined by the storyboardName parameter
     - Parameter storyboardId: String
     - Parameter storyboardName: String
     - Returns: UIViewController?
     */
    class func viewController(_ storyboardId: String, storyboardName: String) -> UIViewController? {
        let storyboard = storyboardBoardWithName(storyboardName)
        let viewController: AnyObject = storyboard.instantiateViewController(withIdentifier: storyboardId)
        return viewController as? UIViewController
    }
    
    /**
     Method returns an instance of the storyboard defined by the storyboardName String parameter
     - Parameter storyboardName: UString
     - Returns: UIStoryboard
     */
    class func storyboardBoardWithName(_ storyboardName: String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard
    }
    /**
     Method returns an instance of a nib defined by the name String parameter
     - Parameter name: String
     - Returns: UINib?
     */
    class func nib(_ name: String) -> UINib? {
        let nib: UINib? = UINib(nibName: name, bundle: Bundle.main)
        return nib
    }
    /**
     Method returns an instance of a view defined by the nib name String parameter
     - Parameter nibName: String
     - Returns: UIView?
     */
    class func viewFrom(_ nibName: String) -> UIView? {
        let objects = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        if objects!.count > 0 {
            return objects![0] as? UIView
        }
        return nil
    }
    
    // MARK: UITableView
    /**
     Method registers a nib name defined by the nibName String parameter with the tableview given by the tableview parameter
     - Parameter nibName:        String
     - Parameter tableView: UITableView
     */
    class func registerNibWithTableView(_ nibName: String, tableView: UITableView) {
        let nib = ViewService.nib(nibName)
        tableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    // MARK: UICollectionView
    /**
     Method registers a nib name defined by the nibName String parameter with the collectionView given by the collectionView parameter
     - Parameter nibName:        String
     - Parameter collectionView: UICollectionView
     */
    class func registerNibWithCollectionView(_ nibName: String, collectionView: UICollectionView) {
        let nib = ViewService.nib(nibName)
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    /**
     Method registers a supplementary element of kind nib defined by the nibName String parameter and the kind String parameter with the collectionView parameter
     - Parameter nibName:        String
     - Parameter kind:           String
     - Parameter collectionView: UICollectionView
     */
    class func registerSupplementaryElementOfKindNibWithCollectionView(nibName: String, kind: String, collectionView: UICollectionView) {
        let nib = ViewService.nib(nibName)
        collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: nibName)
    }
    class func findTopMostViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    class func clearViewController(viewController: UIViewController, completedAction: (()->())? = nil) {
        clear(viewController: viewController)
        if let completedAction = completedAction {
            completedAction()
        }
    }
    class func clear(viewController: UIViewController) {
        if let presentedViewController = viewController.presentedViewController {
            clear(viewController: presentedViewController)
            return
        }
        else if let tabBarController = viewController as? UITabBarController, checkIfTabBarControllerIsCleared(tabBarController: tabBarController) == false {
            if let viewControllers = tabBarController.viewControllers {
                for tabBarViewController in viewControllers {
                    clear(viewController: tabBarViewController)
                }
            }
            clear(viewController: tabBarController)
            return
        }
        else if let navigationController = viewController as? UINavigationController, checkIfNavigationControllerIsCleared(navigationController: navigationController) == false{
            navigationController.viewControllers = [navigationController.viewControllers[0]]
            clear(viewController: navigationController)
            return
        }
        else if let presentingViewController = viewController.presentingViewController {
            viewController.dismiss(animated: false, completion: {
                clear(viewController: presentingViewController)
            })
            
            return
            
        }
    }
    class func checkIfTabBarControllerIsCleared(tabBarController: UITabBarController) -> Bool{
        if let viewControllers = tabBarController.viewControllers {
            let filterViewController = viewControllers.filter({ (vc) -> Bool in
                if vc.presentingViewController == nil && vc.presentedViewController == nil  {
                    if let vc = vc as? UINavigationController {
                        return checkIfNavigationControllerIsCleared(navigationController: vc)
                    }
                    else {
                        return true
                    }
                }
                return false
            })
            if filterViewController.count == viewControllers.count{
                return true
            }
            return false
        }
        return true
    }
    class func checkIfNavigationControllerIsCleared(navigationController: UINavigationController) -> Bool {
        if navigationController.viewControllers.count == 1 {
            return true
        }
        return false
    }
    class func checkIfViewControllerIsCleared(viewController: UIViewController) -> Bool {
        if viewController.presentingViewController == nil, viewController.presentedViewController == nil {
            return true
        }
        return false
    }
    
    class func renderShowHideView(isShow: Bool, zeroHeightConstraint: NSLayoutConstraint, bottomSpaceConstraint: NSLayoutConstraint) {
        zeroHeightConstraint.isActive = !isShow
        bottomSpaceConstraint.isActive = isShow
    }
    
    class func showLoadingIndicator() {
        CustomLoadingView.sharedInstance.show()
    }
    class func hideLoadingIndicator() {
        CustomLoadingView.sharedInstance.hide()
    }
}
