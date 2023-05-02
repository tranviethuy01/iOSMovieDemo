//
//  MovieDetailPresenter.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation

class MovieDetailPresenter: NSObject, MovieDetailPresenterProtocol{
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var wireFrame: MovieDetailWireFrameProtocol?
    
    var movieId: Int = 0
    var movie: Movie?
    let queue = DispatchQueue.init(label: "demo.ios.moviedetail")
    var currentRequestToCompleted: Int = 0
 
    func viewDidLoad() {
        if let view = view {
            view.beginLoading()
        }
        reloadData()
    }
    
    func reloadData() {
        currentRequestToCompleted = 1
        if let interactor = interactor {
            interactor.getMovie(movieId: movieId)
        }
    }
    
    func checkReloadRequestToCompleted() {
        queue.async {[weak self] in
            if let weakSelf = self {
                weakSelf.currentRequestToCompleted -= 1
                if weakSelf.currentRequestToCompleted == 0 {
                    DispatchQueue.main.async {[weak self] in
                        if let weakSelf = self, let view = weakSelf.view {
                            view.endLoading()
                            view.updateView()
                        }
                    }
                }
            }
        }
    }
   
    func addToWatchList(isOnMyWatchList: Bool) {
        currentRequestToCompleted = 1
        if let view = view {
            view.beginLoading()
        }
        
        if let interactor = interactor {
            interactor.addToWatchList(movieId: movieId, isOnMyWatchList: isOnMyWatchList)
        }
    }
    
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func getMovieSuccess(movie: Movie) {
        self.movie = movie
        checkReloadRequestToCompleted()
    }
    
    func getMovieFail() {
        checkReloadRequestToCompleted()
    }
    
    func addToWatchListSuccess(movie: Movie) {
        self.movie = movie
        checkReloadRequestToCompleted()
    }
    
    func addToWatchListFail() {
        //some hard code here to test the function
        self.movie?.isOnMyWatchList = true
        checkReloadRequestToCompleted()
    }
}
