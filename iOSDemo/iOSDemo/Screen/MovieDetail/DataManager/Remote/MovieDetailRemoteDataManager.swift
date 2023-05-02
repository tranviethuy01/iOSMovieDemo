//
//  MovieDetailRemoteDataManager.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
import ObjectMapper

class MovieDetailRemoteDataManager: MovieDetailRemoteDataManagerInputProtocol {
    
    weak var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol?
    func getMovie(movieId: Int) {
        APIServiceManager.sharedInstance.getMovie(movieId: movieId) {[weak self] (errorPackage, responsePackage) in
            if let responsePackage = responsePackage, let value = responsePackage.value as? [String:Any], let data = value ["data"] as? [String:Any] {
                if let movie = Movie.init(JSON: data), let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.getMovieSuccess(movie: movie)
                    return
                }
            }
            else if let errorPackage = errorPackage, let _ = errorPackage.code, let value = errorPackage.value as? [String:Any], let errors = value["errors"] as? [[String: Any]], errors.count > 0, let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler  {
                remoteRequestHandler.getMovieFail()
                return
            }
            if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                remoteRequestHandler.getMovieFail()
            }
        }
    }
    
    func addToWatchList(movieId: Int, isOnMyWatchList: Bool) {
        
        /*
        APIServiceManager.sharedInstance.addToWatchList(movieId: movieId) {[weak self] (errorPackage, responsePackage) in
            if let responsePackage = responsePackage, let value = responsePackage.value as? [String:Any], let data = value ["data"] as? [String:Any] {
                if let movie = Movie.init(JSON: data), let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    movie.isOnMyWatchList = isOnMyWatchList
                    remoteRequestHandler.addToWatchListSuccess(movie: movie)
                    return
                }
            }
            else if let errorPackage = errorPackage, let _ = errorPackage.code, let value = errorPackage.value as? [String:Any], let errors = value["errors"] as? [[String: Any]], errors.count > 0, let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler  {
                remoteRequestHandler.addToWatchListFail()
                return
            }
            if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                remoteRequestHandler.addToWatchListFail()
            }
        }
         */
    }
    
}
