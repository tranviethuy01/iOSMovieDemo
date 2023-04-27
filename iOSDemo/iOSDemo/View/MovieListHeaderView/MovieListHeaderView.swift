//
//  MovieListHeaderView.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import UIKit

protocol MovieListHeaderViewDelegate: AnyObject {
    func movieListHeaderViewDidTapSort (_ view:MovieListHeaderView)
}

class MovieListHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLbl: UILabel!
    
    
    @IBOutlet weak var sortWrapperView: UIView!
    
    weak var delegate: MovieListHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.text = "Movies"
        contentView.backgroundColor = UIColor.clear
        
        sortWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(sortWrapperView_Tap)))
        
    }
    
    @objc func sortWrapperView_Tap() {
        if let delegate = delegate {
            delegate.movieListHeaderViewDidTapSort(self)
        }
    }
    
        
    class func getViewIdentifier() -> String {
        return "MovieListHeaderView"
    }
    
    class func getHeight() -> CGFloat {
        return 84
    }
}
