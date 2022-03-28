//
//  MovieDetailViewController.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieId : Int!
    var viewModel : MovieDetailViewModel!
    var movieDetail : MovieDetail!
    
    init(movieId : Int) {
        self.movieId = movieId
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = MovieDetailViewModel(useCase: MovieDetailUseCase())
        viewModel.getMovieDetail(movieId: movieId)
        bindViewModel()
    }
}

extension MovieDetailViewController {
    private func setupUI() {
        loadingIndicator.startAnimating()
    }
    
    private func bindViewModel() {
        viewModel.didReceiveMovieDetail = { [weak self] in
            self?.movieDetail = self?.viewModel.movieDetail
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.reloadUI()
            }
        }
        viewModel.didReceiveError = { message in
            fatalError(message)
        }
    }
    
    private func reloadUI() {
        let url = URL(string: "https://image.tmdb.org/t/p/w185/\(movieDetail.backdrop_path)")
        posterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = movieDetail.title
        releaseDateLabel.text = movieDetail.release_date
        overviewLabel.text = movieDetail.overview
    }
}
