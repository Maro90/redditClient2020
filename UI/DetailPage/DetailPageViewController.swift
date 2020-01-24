//
//  DetailPageViewController.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController {

    @IBOutlet var titleLabel:       UILabel!
    @IBOutlet var imageThumbnail:   UIImageView!

    var entrySelected: RedditEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let entry = entrySelected {
            loadData(entry)
        }
    }
    
    func loadData(_ data: RedditEntry){
        self.titleLabel.text = data.title

        if let image = data.thumbnailURL {
            let url = URL(string: image)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }

                DispatchQueue.main.async {
                    self.imageThumbnail.image = UIImage(data: data!)
                }
            }).resume()
        }
    }
}

extension DetailPageViewController: EntrySelectionDelegate {
    func entrySelected(_ entry: RedditEntry){
        entrySelected = entry
        DispatchQueue.main.async {
            self.loadData(entry)
        }
    }
}
