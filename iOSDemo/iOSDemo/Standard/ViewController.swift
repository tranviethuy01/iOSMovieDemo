//
//  ViewController.swift
//  iOSDemo
//
//  Created by Viet Huy on 12/3/22.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    /**
     This function is called when first times application call viewDidAppear, after that, this func is not called anymore. If you want to use, override this, please put super.viewDidAppear(animated) in your ViewController-inherited controller's viewDidAppear function
     */
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidChangeFrame(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc func keyboardDidShow (_ notification: Notification) {
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
    @objc func keyboardDidHide( _ notification: Notification) {
        
    }
    @objc func keyboardWillChangeFrame( _ notification: Notification) {
        
    }
    @objc func keyboardDidChangeFrame( _ notification: Notification) {
        
    }
    
    class func storyBoardId() -> String {
        return ""
    }
    
    class func storyBoardName() -> String {
        return ""
    }
    
    class func initWithStoryBoard() -> Self? {
        if let vc = ViewService.viewController(storyBoardId(), storyboardName: storyBoardName()) as? Self {
            return vc
        }
        return nil
        
    }
}
