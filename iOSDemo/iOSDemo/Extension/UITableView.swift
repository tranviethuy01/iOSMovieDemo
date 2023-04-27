//
//  UITableView.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import UIKit
extension UITableView {
    public override var intrinsicContentSize: CGSize {
      self.layoutIfNeeded()
      return self.contentSize
    }

    public override var contentSize: CGSize {
      didSet{
        self.invalidateIntrinsicContentSize()
      }
    }

//    override func reloadData() {
//      super.reloadData()
//      self.invalidateIntrinsicContentSize()
//    }
    
}


