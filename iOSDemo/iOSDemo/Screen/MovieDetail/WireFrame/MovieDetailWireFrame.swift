//
//  MovieDetailWireFrame.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
class MovieDetailWireFrame: MovieDetailWireFrameProtocol {
    static func createMovieDetailViewController(movieId: Int) -> MovieDetailViewController? {
        if let vc = MovieDetailViewController.initWithStoryBoard() {
            let presenter = MovieDetailPresenter()
            let interactor = MovieDetailInteractor()
            let wireFrame = MovieDetailWireFrame()
            let remoteDataManager = MovieDetailRemoteDataManager()
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            presenter.view = vc
            presenter.movieId = movieId
            vc.presenter = presenter
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            return vc
        }
        return nil
    }
}
