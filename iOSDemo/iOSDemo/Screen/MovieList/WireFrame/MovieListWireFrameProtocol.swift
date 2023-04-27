//
//  MovieListWireFrameProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

protocol MovieListWireFrameProtocol: AnyObject{
    static func createMovieListViewController() -> MovieListViewController?
    func showMovieDetail(movieId: Int, from view: MovieListViewProtocol)
}
