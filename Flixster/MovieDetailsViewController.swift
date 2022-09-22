//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Mina Sedhom on 9/17/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var movie: [String:Any]!
    
    
    @objc func posterTapped() {
        print("Poster Tappeddd")
        let movieId = self.movie["id"] as! Int
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = dataDictionary["results"] as! [[String:Any]]
                //print(results)
                for d in results {
                    if d["type"] as! String == "Trailer" {
                        let key = d["key"] as? String
                        let vc = self.storyboard!.instantiateViewController(withIdentifier: "MovieTrailerViewController") as! MovieTrailerViewController
                        vc.trailerKey = key
                        self.present(vc, animated: true)
                    }
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        dateLabel.text = movie["release_date"] as? String
        dateLabel.sizeToFit()
        
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.posterTapped)))
        
        let baseUrl = "https://image.tmdb.org/t/p/"
        if let posterPath = movie["poster_path"] as? String {
            let posterUrl = URL(string: baseUrl + "w185" + posterPath)
            posterView.af.setImage(withURL: posterUrl!)
            posterView.layer.borderWidth = 1
            posterView.layer.borderColor = UIColor.white.cgColor
            
        }
        
        if let backdropPath = movie["backdrop_path"] as? String {
            let backdropUrl = URL(string: baseUrl + "w780" + backdropPath)
            backdropView.af.setImage(withURL: backdropUrl!)
        }
        
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
