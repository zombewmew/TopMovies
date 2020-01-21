//
//  MovieCell.swift
//  TopMovies
//
//  Created by christina on 17.01.2020.
//  Copyright © 2020 Christina S. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var MovieView: UIView!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var PosterImage: UIImageView!
    @IBOutlet weak var SheduleButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        MovieView.layer.shadowColor = UIColor.gray.cgColor
        MovieView.layer.shadowOpacity = 0.5
        MovieView.layer.shadowOffset = .zero
        MovieView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
