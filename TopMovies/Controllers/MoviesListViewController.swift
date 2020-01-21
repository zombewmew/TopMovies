//
//  MoviesListViewController.swift
//  TopMovies
//
//  Created by christina on 21.01.2020.
//  Copyright © 2020 Christina S. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieManager = RequestManager()
    var movies: [MoviesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        movieManager.delegate = self
        movieManager.fetchMovies()
        
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        if #available(iOS 13.0, *) {
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.white
            view.addSubview(statusbarView)
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.white
        }
    }
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieCell

        cell.TitleLabel.text = movie.name
        cell.DescriptionLabel.text = movie.description
        cell.ScoreLabel.text = String(Int(movie.score * 10))
        cell.DateLabel.text = formatDate(dateMovie: movie.date)
        
        print("Begin of code")

        let url = URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2" + movie.posterUrl)
        
        downloadImage(from: url!, imagePlace: cell.PosterImage!)
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
        
        return cell
    }
    
    
    
    func downloadImage(from url: URL, imagePlace: UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print("Download Finished")
            DispatchQueue.main.async() {
                imagePlace.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func formatDate(dateMovie: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"

        if let date = dateFormatterGet.date(from: dateMovie) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
            return ""
        }
    }
    
    
}


//MARK: - RequestManagerDelegate

extension MoviesListViewController: RequestManagerDelegate {
    func didUpdateMovies(_ RequestManager: RequestManager, movies: [MoviesModel]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
