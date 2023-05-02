//
//  MovieListWireFrame.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
enum MovieListSortType: String {
    case title = "title"
    case releaseDate = "releaseDate"
    case none = "none"
}


class MovieListPresenter: MovieListPresenterProtocol {
    weak var view: MovieListViewProtocol?
    var wireFrame: MovieListWireFrameProtocol!
    var interactor: MovieListInteractorInputProtocol!
    let concurrentQueue = DispatchQueue.init(label: "demo.ios.movielist")
    var reloadRequestToComplete = 0
    var movies: [Movie]?
    var sortType : MovieListSortType = .none
    
    func viewDidLoad() {
        if let sortTypeStr = UserDefaults.standard.string(forKey: "sortType") {
            print("sortTypeStr : \(sortTypeStr)")
            if sortTypeStr == MovieListSortType.title.rawValue {
                sortType = .title
            } else if sortTypeStr == MovieListSortType.releaseDate.rawValue {
                sortType = .releaseDate
            }
        }
        
        if let view = view {
            view.reloadData()
        }
    }
    
    func reloadData() {
        concurrentQueue.async {[weak self] in
            if let weakSelf = self {
                weakSelf.reloadRequestToComplete = 1
            }
        }
        interactor.getMovieList()
    }

    func checkReloadRequestToComplete() {
        concurrentQueue.async {[weak self] in
            if let weakSelf = self {
                weakSelf.reloadRequestToComplete -= 1
                DispatchQueue.main.async {[weak self] in
                    if let weakSelf = self, let view = weakSelf.view , weakSelf.reloadRequestToComplete <= 0{
                        view.endReloading()
                        weakSelf.sortMoviesByType()
                        view.updateView()
                    }
                }
            }
            
        }
    }
    
    func showMovieDetail(movieId: Int) {
        if let view = view {
            wireFrame.showMovieDetail(movieId: movieId, from: view)
        }
    }
    
    func updateSortType(sortType: MovieListSortType) {
        UserDefaults.standard.set(sortType.rawValue, forKey: "sortType")
        
        self.sortType = sortType
        sortMoviesByType()
        if let view = view {
            view.updateView()
        }
    }
    
    private func sortMoviesByType() {
        if let movies = movies {
            switch sortType {
            case .title :
                let sortedArray = movies.sorted { $0.title ?? "" < $1.title ?? ""}
                self.movies = sortedArray
                return
            case .releaseDate:
                let sortedArray = movies.sorted { $0.releasedDate ?? Date() < $1.releasedDate ?? Date()}
                self.movies = sortedArray
                return
            case .none:
                return
            }
        }

    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func didGetMovieListSuccess(movies: [Movie]?) {
        self.movies = movies
        checkReloadRequestToComplete()
    }
    
    func didGetMovieListFail() {
        checkReloadRequestToComplete()
    }
}
