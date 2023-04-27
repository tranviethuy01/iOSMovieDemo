//
//  InitViewController.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import UIKit
class InitViewController: ViewController {

    static let storyboardId: String = "InitViewController"
    static let storyboardName: String = "Init"
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showHomeView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func showHomeView() {
        showMovieList()
    }
    
    private func showMovieList() {
        if let vc = MovieListWireFrame.createMovieListViewController(){
            let navigationController = UINavigationController.init(rootViewController: vc)
            self.presentOverContext(navigationController, animated: true, completion: nil)
        }
    }

}
