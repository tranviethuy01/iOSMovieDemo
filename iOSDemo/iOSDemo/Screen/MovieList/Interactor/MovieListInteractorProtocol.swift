//
//  MovieListInteractorProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

protocol MovieListInteractorInputProtocol: AnyObject{
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var remoteDataManager: MovieListRemoteDataManagerInputProtocol! { get set }
    func getMovieList()
}

protocol MovieListInteractorOutputProtocol: AnyObject{
    func didGetMovieListSuccess(movies: [Movie]?)
    func didGetMovieListFail()
}
