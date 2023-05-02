//
//  MovieListViewController .swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import UIKit



class MovieListViewController: ViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
     
    // MARK: - Properties    
    var presenter: MovieListPresenterProtocol!
    
    var movies: [Movie]? {
        get {
            return presenter!.movies
        }
    }
    
    // MARK: -  View Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup view
        ViewService.registerNibWithTableView(MovieListTableViewCell.getCellIdentifier(), tableView: tableView)
        
        tableView.register(UINib.init(nibName: MovieListHeaderView.getViewIdentifier(), bundle: nil), forHeaderFooterViewReuseIdentifier: MovieListHeaderView.getViewIdentifier())
        
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = MovieListTableViewCell.getCellHeight()
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: 0.1))
        headerView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = headerView
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: 0.1))
        footerView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footerView
        
//        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.addRefreshHeader {[weak self] in
            if let weakSelf = self {
                if weakSelf.tableView.mj_header.isRefreshing == true {
                    weakSelf.tableView.headerEndRefreshing()
                }
                if let presenter = weakSelf.presenter {
                    presenter.reloadData()
                }
            }
        }
        tableView.mj_header.backgroundColor = ColorSystem.ashGray
        tableView.backgroundColor = ColorSystem.ashGray
        tableView.delegate = self
        tableView.dataSource = self
        
        //setupData
        presenter.viewDidLoad()
    }
    
    // MARK: - Override
    override class func storyBoardId() -> String {
        return "MovieListViewController"
    }
    
    override class func storyBoardName() -> String {
        return "MovieList"
    }

    // MARK: - Method
    
    private func updateSortType(sortType: MovieListSortType){
        if let presenter = presenter {
            presenter.updateSortType(sortType: sortType)
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movies = movies, indexPath.row < movies.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.getCellIdentifier(), for: indexPath) as! MovieListTableViewCell
            cell.frame.size.width = ViewService.screenSize().width
            cell.selectionStyle = .none
            cell.setupData(movie: movies[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = presenter, let movies = movies, indexPath.row < movies.count  {
            presenter.showMovieDetail(movieId: movies[indexPath.row].id)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieListHeaderView.getViewIdentifier()) as! MovieListHeaderView
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MovieListHeaderView.getHeight()
    }
    
}

extension MovieListViewController: MovieListViewProtocol{
    func endReloading() {
        ViewService.hideLoadingIndicator()
        tableView.headerEndRefreshing()
    }
    
    func reloadData() {
        ViewService.showLoadingIndicator()
        tableView.headerBeginRefreshing()
    }
    
    func updateView() {
        tableView.reloadData()
    }
}

extension MovieListViewController: MovieListHeaderViewDelegate{
    func movieListHeaderViewDidTapSort(_ view: MovieListHeaderView) {
        let alertController = UIAlertController(title: "Sort movies by", message: nil, preferredStyle: .alert)
        let optionSortTitleAction = UIAlertAction(title: "Title", style: .default) { (action) in
            self.updateSortType(sortType: .title)
        }
        let optionSortReleasedDateAction = UIAlertAction(title: "Released Date", style: .default) { (action) in
            self.updateSortType(sortType: .releaseDate)
        }

        let optionCancelSortAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            // do nothing
        }
        optionSortTitleAction.setValue(UIColor.gray, forKey: "titleTextColor")
        optionSortReleasedDateAction.setValue(UIColor.gray, forKey: "titleTextColor")
        optionCancelSortAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(optionSortTitleAction)
        alertController.addAction(optionSortReleasedDateAction)
        alertController.addAction(optionCancelSortAction)
        present(alertController, animated: true, completion: nil)

    }
}

