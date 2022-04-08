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
    var isLoading = false
    var movies = [Movie]()
    var currentPage = 1
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
        viewModel.getPopularMovies(page: currentPage)
    }
    
    private func bindViewModel() {
        viewModel.didReceivePopularMovies = { [weak self] in
            guard let result = self?.viewModel.moviesResult else { return }
            self?.movies.append(contentsOf: result.results)
            self?.currentPage = result.page
            DispatchQueue.main.async { self?.updateTableView() }
        }
        
        viewModel.didReceiveError = { error in
            fatalError(error)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position >
            (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        let nextPage = currentPage + 1
        if currentPage >= 1 {
            if !self.isLoading {
                self.isLoading = true
                DispatchQueue.global().async { [weak self] in
                    self?.viewModel.getPopularMovies(page: nextPage)
                }
            }
        }
    }
    
    func updateTableView() {
        tableView.reloadData()
        isLoading = false
    }
}

extension MovieListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.MovieListViewCellID, for: indexPath) as? MovieListViewCell
        cell?.configureCell(movie: movies[indexPath.row])
        return cell ?? UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 { return 55 }
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController(movieId: movies[indexPath.row].id)
        self.present(vc, animated: true, completion: nil)
    }
}
