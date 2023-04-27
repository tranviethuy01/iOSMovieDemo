//
//  MovieListRemoteDataManager.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import ObjectMapper
class MovieListRemoteDataManager: MovieListRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol?
    
    func getMovieList() {
        APIServiceManager.sharedInstance.getMovieList() {[weak self] (errorPackage, responsePackage) in
            if let responsePackage = responsePackage, let value = responsePackage.value as? [String:AnyObject] {
                if let listDict = value[Constant.kData] as? [[String:AnyObject]] {
                    var movies: [Movie] = []
                    for element in listDict {
                        if let movie = Movie.init(JSON: element) {
                            movies.append(movie)
                        }
                    }
                    
                    if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.getMovieListSuccess(movies: movies)
                        return
                    }
                }
            }
            else if let errorPackage = errorPackage, let code = errorPackage.code, code == 404 {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.getMovieListSuccess(movies: nil)
                    return
                }
            }
            if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                remoteRequestHandler.getMovieListFail()
            }
        }
    }
    
}
