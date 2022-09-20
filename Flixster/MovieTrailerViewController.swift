//
//  MovieTrailerViewController.swift
//  Flixster
//
//  Created by Mina Sedhom on 9/19/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    
    @IBOutlet weak var trailerWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let trailerURL = URL(string: "https://www.youtube.com/watch?v=SUXWAEX2jlg"){ trailerWebView.load(.init(url: trailerURL))}
        
       
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
