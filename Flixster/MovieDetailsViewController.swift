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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movie["title"])
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        dateLabel.text = movie["release_date"] as? String
        dateLabel.sizeToFit()

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
