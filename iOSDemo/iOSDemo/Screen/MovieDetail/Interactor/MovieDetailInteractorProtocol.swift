//
//  MovieDetailInteractorProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation

protocol MovieDetailInteractorInputProtocol: AnyObject {
    var presenter: MovieDetailInteractorOutputProtocol? {get set}
    var remoteDataManager: MovieDetailRemoteDataManagerInputProtocol? {get set}
    func getMovie(movieId: Int)
    func addToWatchList(movieId: Int, isOnMyWatchList: Bool)
}
protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func getMovieSuccess(movie: Movie)
    func getMovieFail()
    func addToWatchListSuccess(movie: Movie)
    func addToWatchListFail()
}
