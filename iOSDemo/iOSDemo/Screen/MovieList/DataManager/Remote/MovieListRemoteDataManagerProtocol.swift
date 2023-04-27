//
//  MovieListRemoteDataManagerProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

protocol MovieListRemoteDataManagerInputProtocol: AnyObject{
    var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol? { get set }
    func getMovieList()
}

protocol MovieListRemoteDataManagerOutputProtocol: AnyObject{
    func getMovieListSuccess(movies: [Movie]?)
    func getMovieListFail()
}
