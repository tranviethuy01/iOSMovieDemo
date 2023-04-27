//
//  MovieListWireFrame.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

class MovieListWireFrame: MovieListWireFrameProtocol {
    static func createMovieListViewController() -> MovieListViewController? {
        if let vc = MovieListViewController.initWithStoryBoard(){
            let presenter = MovieListPresenter()
            let interactor = MovieListInteractor()
            let wireFrame = MovieListWireFrame()
            let remoteDataManager = MovieListRemoteDataManager()
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            presenter.view = vc
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            vc.presenter = presenter
            return vc
        }
        return nil
    }
    
    func showMovieDetail(movieId: Int, from view: MovieListViewProtocol) {
        if let vc = MovieDetailWireFrame.createMovieDetailViewController(movieId: movieId), let view = view as? MovieListViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
