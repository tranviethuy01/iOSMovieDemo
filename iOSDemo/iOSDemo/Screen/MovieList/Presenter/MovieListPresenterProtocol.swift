//
//  MovieListPresenterProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
protocol MovieListPresenterProtocol: AnyObject{
    var view: MovieListViewProtocol? { get set }
    var wireFrame: MovieListWireFrameProtocol! { get set }
    var interactor: MovieListInteractorInputProtocol! { get set }
    var movies: [Movie]? {get set}
    func viewDidLoad()
    func reloadData()
    func showMovieDetail(movieId: Int)
    func updateSortType(sortType: MovieListSortType)
}
