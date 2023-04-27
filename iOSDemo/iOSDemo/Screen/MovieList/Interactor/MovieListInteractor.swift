//
//  MovieListInteractor.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

class MovieListInteractor: MovieListInteractorInputProtocol {
    weak var presenter: MovieListInteractorOutputProtocol?
    var remoteDataManager: MovieListRemoteDataManagerInputProtocol!
    
    func getMovieList() {
        remoteDataManager.getMovieList()
    }
}

extension MovieListInteractor: MovieListRemoteDataManagerOutputProtocol {
    func getMovieListSuccess(movies: [Movie]?) {
        if let presenter = presenter {
            presenter.didGetMovieListSuccess(movies: movies)
        }
    }
    
    func getMovieListFail() {
        if let presenter = presenter {
            presenter.didGetMovieListFail()
        }
    }
    
}
