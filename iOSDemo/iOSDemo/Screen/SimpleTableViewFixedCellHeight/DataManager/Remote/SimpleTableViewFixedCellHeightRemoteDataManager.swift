//
//  SimpleTableViewFixedCellHeightRemoteDataManager.swift
//  iOSDemo
//
//  Created by Viet Huy on 12/3/22.
//


import Foundation
import ObjectMapper
protocol SimpleTableViewFixedCellHeightRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: SimpleTableViewFixedCellHeightRemoteDataManagerOutputProtocol? {get set}
    
}
protocol SimpleTableViewFixedCellHeightRemoteDataManagerOutputProtocol: AnyObject {
    
}

class SimpleTableViewFixedCellHeightRemoteDataManager: SimpleTableViewFixedCellHeightRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: SimpleTableViewFixedCellHeightRemoteDataManagerOutputProtocol?
    
}
    
