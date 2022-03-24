//
//  HomeViewController.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : MovieListViewModel!
    var viewModel2 : MovieDetailViewModel!
    var isLoading = false
    var movies = [Movies]()
    var currentMovieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupViewModel()
        bindViewModel()
    }
}

extension MovieListViewController {
    private func setupUI() {
        title = Constant.HomePageTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constant.MovieListViewCellID, bundle: nil), forCellReuseIdentifier: Constant.MovieListViewCellID)
        let tableViewLoadingCellNib = UINib(nibName: Constant.LoadingViewCellID, bundle: nil)
        tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: Constant.LoadingViewCellID)
    }
    
    private func setupViewModel() {
        viewModel = MovieListViewModel(useCase: MovieListUseCase())
        viewModel.getPopularMovies(page: 1)
        viewModel2 = MovieDetailViewModel(useCase: MovieDetailUseCase())
        viewModel2.getMovieDetail(movieId: 2321)
    }
    
    private func bindViewModel() {
        viewModel.didReceiveMovies = { [weak self] in
            self?.movies.append((self?.viewModel.moviesResult)!)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.isLoading = false
            }
        }
        viewModel2.didReceiveMovieDetail = { [weak self] in
//            print(self?.viewModel2.movieDetail, "<<<< RESULT")
        }
        viewModel.didReceiveError = { error in
            print(error)
            fatalError(error)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            loadMoreData()
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

extension MovieListViewController : UITableViewDelegate, UITableViewDataSource {
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
                print(indexPath.row, results.count, "<<< index")
                let movie = results[indexPath.row % results.count]
                currentMovieId = movie.id
                cell?.configureCell(movie: results[indexPath.row % results.count])
                cell?.tapButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
            }
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.LoadingViewCellID, for: indexPath) as? LoadingViewCell
            cell?.spinner.startAnimating()
            return cell!
        }
    }
    @objc func goToDetail() {
        let vc = MovieDetailViewController(movieId: currentMovieId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 {
            return 55 //Loading Cell height
        }
        return 240
    }
}
