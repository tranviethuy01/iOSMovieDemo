//
//  MovieDetailRemoteDataManagerProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation

protocol MovieDetailRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? {get set}
    func getMovie(movieId: Int)
    func addToWatchList(movieId: Int, isOnMyWatchList: Bool)
}

protocol MovieDetailRemoteDataManagerOutputProtocol: AnyObject {
    func getMovieSuccess(movie: Movie)
    func getMovieFail()
    func addToWatchListSuccess(movie: Movie)
    func addToWatchListFail()
}
