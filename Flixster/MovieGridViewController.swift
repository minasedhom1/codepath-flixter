//
//  MovieGridViewController.swift
//  Flixster
//
//  Created by Mina Sedhom on 9/18/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.collectionView.reloadData()
                print(self.movies)
            }
        }
        task.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieGridCell.self), for: indexPath) as! MovieGridCell
        // configure the cell in between
        
        let movie = movies[indexPath.item]
        //cell.posterView.image = UIImage(contentsOfFile: "superhero_tabbar_item")
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        if let posterPath = movie["poster_path"] as? String {
            let posterUrl = URL(string: baseUrl + posterPath)
            cell.posterView.af.setImage(withURL: posterUrl!)
        }
        
        //return the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 5
        return .init(width: (collectionView.frame.width - spacing) / 2, height: collectionView.frame.height / 3)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading up the details screen!")
        
        //Find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the details view controller
        
        let detailViewController = segue.destination as! MovieDetailsViewController
        
        detailViewController.movie = movie
        
    }
    
}
