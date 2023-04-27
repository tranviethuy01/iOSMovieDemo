//
//  MovieDetailViewProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
protocol MovieDetailViewProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol! {get set}
    func beginLoading()
    func endLoading()
    func updateView()
}
