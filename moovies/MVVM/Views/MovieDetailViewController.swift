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
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var voteAvgView: UIView!
    @IBOutlet weak var voteAvgLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var watchNowBtn: UIButton!
    
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
    @IBAction func watchNowTapped(_ sender: Any) {
        
    }
}

extension MovieDetailViewController {
    private func setupUI() {
        loadingIndicator.roundedCorner()
        loadingIndicator.startAnimating()
        voteAvgView.roundedCorner(width: 0, color: UIColor.black.cgColor, radius: voteAvgView.frame.width/2)
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
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w185/\(movieDetail.backdrop_path)")
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185/\(movieDetail.poster_path)")
        backdropImageView.sd_setImage(with: backdropUrl, completed: nil)
        posterImageView.sd_setImage(with: posterUrl, completed: nil)
        posterImageView.roundedCorner()
        titleLabel.text = movieDetail.title
        releaseDateLabel.text = "Release on \(movieDetail.release_date.getDateString(separator: "-"))"
        overviewLabel.text = movieDetail.overview
        taglineLabel.text = " \"\(movieDetail.tagline)\" "
        budgetLabel.text = movieDetail.budget.formatPriceNumber()
        let voteAvg = movieDetail.vote_average
        voteAvgLabel.text = String(voteAvg)
        if voteAvg <= 4 {
            voteAvgView.backgroundColor = UIColor.systemRed
            voteAvgLabel.textColor = .white
        } else if voteAvg < 7.5 {
            voteAvgView.backgroundColor = UIColor.systemYellow
            voteAvgLabel.textColor = .black
        } else if voteAvg >= 7.5 {
            voteAvgView.backgroundColor = UIColor.systemGreen
            voteAvgLabel.textColor = .white
        }
    }
}
