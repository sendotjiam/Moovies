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
        return searchBar
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var stackView : UIStackView!
    
    private var viewModel : MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupStackView()
        bindViewModel()
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListViewCell", for: indexPath) as? MovieListViewCell
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController {
    private func bindViewModel() {
        viewModel.didSearchedMovies = { [weak self] in
            
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
        stackView = UIStackView(arrangedSubviews: [searchBar])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
}

extension SearchViewController : UISearchBarDelegate {
    
}
