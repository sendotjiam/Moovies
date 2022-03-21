//
//  HomeViewController.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : MovieListViewModel!
    var isLoading = false
    var movies = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = MovieListViewModel(useCase: MovieListUseCase())
        bindViewModel()
        viewModel.getPopularMovies(page: 1)
    }
}

extension HomeViewController {
    private func setupUI() {
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieListViewCell", bundle: nil), forCellReuseIdentifier: Constant.MovieListViewCellID)
        
        let tableViewLoadingCellNib = UINib(nibName: "LoadingViewCell", bundle: nil)
        tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: Constant.LoadingViewCellID)
    }
    
    private func bindViewModel() {
        viewModel.didReceiveMovies = { [weak self] in
            self?.movies.append((self?.viewModel.moviesResult)!)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.isLoading = false
            }
        }
        viewModel.didReceiveError = { error in
            print(error?.localizedDescription ?? "")
            fatalError(error?.localizedDescription ?? "")
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            loadMoreData()
            print("Reach the bottom of table view")
        }
    }
    
    func loadMoreData() {
        let currentPage = getCurrentPageIdx()
        let nextPage = getCurrentPageIdx() + 1
        if currentPage >= 1 {
            if !self.isLoading {
                self.isLoading = true
                DispatchQueue.global().async { [weak self] in
                    self?.viewModel.getPopularMovies(page: nextPage)
                }
            }
        }
    }
    
    func getCurrentPageIdx() -> Int {
        return movies.last?.page ?? -1
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            var numberOfRow = 0
            for i in 0..<movies.count {
                numberOfRow += movies[i].results.count
            }
            return numberOfRow
        } else if section == 1 {
            return 1
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.MovieListViewCellID, for: indexPath) as? MovieListViewCell
            for i in 0..<movies.count {
                let results =  movies[i].results
                cell?.configureCell(movie: results[indexPath.row % results.count])
            }
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.LoadingViewCellID, for: indexPath) as? LoadingViewCell
            cell?.spinner.startAnimating()
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 {
            return 55 //Loading Cell height
        }
        return 240
    }
}
