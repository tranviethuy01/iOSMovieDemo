//
//  MovieListViewProtocol.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation

protocol MovieListViewProtocol: AnyObject{
    var presenter: MovieListPresenterProtocol! { get set }    
    func updateView()
    func endReloading()
    func reloadData()
}
