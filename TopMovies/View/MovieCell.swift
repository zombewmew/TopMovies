//
//  MovieCell.swift
//  TopMovies
//
//  Created by christina on 17.01.2020.
//  Copyright © 2020 Christina S. All rights reserved.
//

import UIKit

protocol MovieCellDelegate {
    func GetMovieInfo(title: String)
}

class MovieCell: UITableViewCell {
    
    var delegate: MovieCellDelegate?

    @IBOutlet weak var MovieView: UIView!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var PosterImage: UIImageView!

    @IBAction func SheduleShow(_ sender: UIButton) {

        if (self.delegate != nil) {
            self.delegate?.GetMovieInfo(title: TitleLabel.text!)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        MovieView.layer.shadowColor = UIColor.gray.cgColor
        MovieView.layer.shadowOpacity = 0.5
        MovieView.layer.shadowOffset = .zero
        MovieView.layer.shadowRadius = 5
        
    }

}
