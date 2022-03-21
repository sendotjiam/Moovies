//
//  LoadingViewCell.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import UIKit

class LoadingViewCell: UITableViewCell {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
