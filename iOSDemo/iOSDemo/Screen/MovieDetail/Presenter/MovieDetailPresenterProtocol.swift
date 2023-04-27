//
//  MovieDetailPresenterProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
protocol MovieDetailPresenterProtocol: AnyObject {
    var view: MovieDetailViewProtocol? {get set}
    var interactor: MovieDetailInteractorInputProtocol? {get set}
    var wireFrame: MovieDetailWireFrameProtocol? {get set}
    var movie: Movie? {get set}
    var movieId: Int {get set}
    func viewDidLoad()
    func reloadData()
    func addToWatchList()
}
