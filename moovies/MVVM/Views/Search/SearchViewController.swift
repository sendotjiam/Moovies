//
//  SearchViewController.swift
//  moovies
//
//  Created by Sendo Tjiam on 08/04/22.
//

import UIKit

class SearchViewController: UIViewController {

    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return searchBar
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var stackView : UIStackView!
    private var spinner = UIActivityIndicatorView()
    
    private var viewModel : MovieListViewModel!
    
    private var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupStackView()
        
        viewModel = MovieListViewModel(useCase: MovieListUseCase())
        bindViewModel()
        
        setupSpinner()
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListViewCell", for: indexPath) as? MovieListViewCell
        cell?.configureCell(movie: movies[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func updateTableView() {
        tableView.reloadData()
        spinner.stopAnimating()
    }
}

extension SearchViewController {
    private func bindViewModel() {
        viewModel.didSearchMovies = { [weak self] in
            guard let result = self?.viewModel.moviesResult else { return }
            self?.movies = result.results
            DispatchQueue.main.async {
                self?.updateTableView()
            }
        }
        
        viewModel.didReceiveError = { message in
            print(message)
        }
    }
    
    private func setupUI() {
        title = "Search"
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieListViewCell", bundle: nil), forCellReuseIdentifier: "MovieListViewCell")
    }
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [searchBar, tableView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    private func setupSpinner () {
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        viewModel.searchMovies(keyword: query.trimmingCharacters(in: .whitespacesAndNewlines))
        spinner.startAnimating()
    }
}
