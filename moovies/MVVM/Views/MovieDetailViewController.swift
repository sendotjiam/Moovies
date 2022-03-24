//
//  MovieDetailViewController.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieId : Int!
    
    init(movieId : Int) {
        self.movieId = movieId
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movieId)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
