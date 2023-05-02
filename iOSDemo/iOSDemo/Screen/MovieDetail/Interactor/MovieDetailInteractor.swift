//
//  MovieDetailInteractor.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    weak var presenter: MovieDetailInteractorOutputProtocol?
    var remoteDataManager: MovieDetailRemoteDataManagerInputProtocol?
    func getMovie(movieId: Int) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getMovie(movieId: movieId)
        }
        
    }
    
    func addToWatchList(movieId: Int, isOnMyWatchList: Bool) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.addToWatchList(movieId: movieId, isOnMyWatchList: isOnMyWatchList)
        }
        
    }
}

extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
    func getMovieSuccess(movie: Movie) {
        if let presenter = presenter {
            presenter.getMovieSuccess(movie: movie)
        }
    }
    
    func getMovieFail() {
        if let presenter = presenter {
            presenter.getMovieFail()
        }
    }
    
    func addToWatchListSuccess(movie: Movie) {
        if let presenter = presenter {
            presenter.addToWatchListSuccess(movie: movie)
        }
    }
    
    func addToWatchListFail() {
        if let presenter = presenter {
            presenter.addToWatchListFail()
        }
    }
    
}
