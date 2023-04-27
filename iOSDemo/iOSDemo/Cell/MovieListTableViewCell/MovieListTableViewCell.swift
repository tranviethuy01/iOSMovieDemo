//
//  MovieListTableViewCell.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
import UIKit

class MovieListTableViewCell: UITableViewCell {
    // MARK: - IBOulet
    
    @IBOutlet weak var contentWrapperView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var metaInfoLbl: UILabel!
    
    @IBOutlet weak var watchListStatusLbl: UILabel!
    
    
    @IBOutlet weak var thumbView: UIImageView!
    
    
    // MARK: - Properties
    var movie: Movie?
    
    // MARK: - Method
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        thumbView.layer.cornerRadius = 10
    }
    
    func setupData(movie: Movie?) {
        self.movie = movie
        didSetupData()
    }
    
    private func didSetupData() {
        if let movie = movie {
            var titleStr: String = ""
            if let title = movie.title {
                titleStr.append(title)
            }
            
            if let releasedDate = movie.releasedDate {
                let timeDateFormatter = DateFormatter.init()
                timeDateFormatter.dateFormat = "YYYY"
                titleStr.append(" (\(timeDateFormatter.string(from: releasedDate)))")
            }
            
            titleLbl.text = titleStr
            
            var metaInfoStr: String = ""
            if let duration = movie.duration {
                metaInfoStr.append(duration)
            }
            
            if let genre = movie.genre {
                metaInfoStr.append(" - \(genre)")
            }
            
            metaInfoLbl.text = metaInfoStr 
            
            if let imageStr = movie.image {
                thumbView.downloadImage(from: "\(imageStr)")
            } else {
                thumbView.image = nil 
            }
            
            if let isOnMyWatchList = movie.isOnMyWatchList, isOnMyWatchList {
                watchListStatusLbl.text = "ON MY WATCH LIST"
            } else {
                watchListStatusLbl.text = ""
            }
        }
    }
    
    class func getCellHeight() -> CGFloat {
        return 180
    }
    
    class func getCellIdentifier() -> String {
        return "MovieListTableViewCell"
    }
}
