//
//  MovieDetailViewController.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieId : Int!
    var viewModel : MovieDetailViewModel!
    
    init(movieId : Int) {
        self.movieId = movieId
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

extension MovieDetailViewController {
    private func setupUI() {
        
    }
}
