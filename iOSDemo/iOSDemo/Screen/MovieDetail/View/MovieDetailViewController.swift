//
//  MovieDetailViewController.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import UIKit

class MovieDetailViewController: ViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var ratingLbl: UILabel!
    
    @IBOutlet weak var addToWatchListWrapperView: UIView!
    
    @IBOutlet weak var addToWatchListLbl: UILabel!
    
    
    @IBOutlet weak var watchTrailerWrapperView: UIView!
    
    @IBOutlet weak var shortDescriptionLbl: UILabel!
    
    @IBOutlet weak var releasedDateValueLbl: UILabel!
    
    @IBOutlet weak var genreValueLbl: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var presenter: MovieDetailPresenterProtocol!
    
    var movie: Movie? {
        get {
            return presenter.movie
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImageView.layer.cornerRadius = 10
        addToWatchListWrapperView.layer.borderWidth = 1
        addToWatchListWrapperView.layer.borderColor = ColorSystem.ashGray.cgColor
        addToWatchListWrapperView.backgroundColor = ColorSystem.ashGray
        addToWatchListWrapperView.layer.cornerRadius = 20
        
        watchTrailerWrapperView.layer.borderWidth = 2
        watchTrailerWrapperView.layer.borderColor = ColorSystem.black.cgColor
        watchTrailerWrapperView.layer.cornerRadius = 20
        
        
        if let movie = movie, let image = movie.image {
            movieImageView.downloadImage(from: image)
        } else {
            movieImageView.image = nil
        }
        
        
        addToWatchListWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addToWatchListWrapperView_Tap)))
        watchTrailerWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(watchTrailerWrapperView_Tap)))
        
        scrollView.addRefreshHeader {[weak self] in
           if let weakSelf = self {
               weakSelf.presenter.reloadData()
           }
        }
        
        let backBarButtonItem = UIBarButtonItem.init(title: "Movies", style: .done, target: self, action: #selector(backBtn_TouchUpInside))
        backBarButtonItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        if let presenter = presenter {
            presenter.viewDidLoad()
        }
    }
    
    func updateView() {
        if let movie = movie {
            if let title = movie.title {
                movieTitle.text = title
            }
            
            if let rating = movie.rating {
                
                let ratingAttributedString = NSMutableAttributedString.init(string: "\(rating)", attributes: [NSAttributedString.Key.foregroundColor: ColorSystem.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
                
                ratingAttributedString.append(NSAttributedString.init(string: "/10", attributes: [NSAttributedString.Key.foregroundColor: ColorSystem.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]))
                ratingLbl.attributedText = ratingAttributedString
            }
            
            if let description = movie.description {
                shortDescriptionLbl.text = description
            }
            
            if let imageStr = movie.image {
                movieImageView.downloadImage(from: "\(imageStr)")
            } else {
                movieImageView.image = nil
            }
            
            if let isOnMyWatchList = movie.isOnMyWatchList, isOnMyWatchList {
                addToWatchListLbl.text = "REMOVE FROM WATCH LIST"
            } else {
                addToWatchListLbl.text = "ADD TO WATCH LIST"
            }
            
            if let genre = movie.genre {
                genreValueLbl.text = genre
            }
            
            var releasedDateStr = ""
            if let releasedDate = movie.releasedDate {
                let timeDateFormatter = DateFormatter.init()
                timeDateFormatter.dateFormat = "YYYY, dd MMMM"
                releasedDateStr.append(timeDateFormatter.string(from: releasedDate))
            }
            releasedDateValueLbl.text = releasedDateStr
        }
    }
    
    
    override class func storyBoardName() -> String {
        return "MovieDetail"
    }
    
    override class func storyBoardId() -> String {
        return "MovieDetailViewController"
    }

    
    @objc func addToWatchListWrapperView_Tap() {
        presenter.addToWatchList()
    }
    
    @objc func watchTrailerWrapperView_Tap() {
        if let movie = movie , let trailerLink = movie.trailerLink {
            if let url = URL(string: trailerLink) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func backBtn_TouchUpInside() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}


extension MovieDetailViewController: MovieDetailViewProtocol {
    func beginLoading() {
        ViewService.showLoadingIndicator()
        scrollView.headerBeginRefreshing()
    }
    
    func endLoading() {
        ViewService.hideLoadingIndicator()
        scrollView.headerEndRefreshing()
    }
}

