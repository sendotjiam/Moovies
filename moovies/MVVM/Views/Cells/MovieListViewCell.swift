//
//  MovieListViewCell.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import UIKit
import SDWebImage

class MovieListViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(
        movie: Movie
    ) {
            let url = URL(string: "https://image.tmdb.org/t/p/w185/\(movie.poster_path)")
            self.movieTitle.text = movie.title
            self.movieReleaseDate?.text = movie.release_date
            self.movieOverview?.text = movie.overview
            self.movieImg.sd_setImage(with: url, completed: nil)
    }
    
}