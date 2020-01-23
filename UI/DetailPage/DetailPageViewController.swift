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
    @IBOutlet var authorLabel:      UILabel!
    @IBOutlet var dateLabel:        UILabel!
    @IBOutlet var imageThumbnail:   UIImageView!
    @IBOutlet var numberOfComments:     UILabel!

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
        self.authorLabel.text = data.author

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
                
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let stringDate = formatter.string(from: data.date)

        self.dateLabel.text = "\(stringDate)"
        self.numberOfComments.text = "Total Comments: \(data.numberOfComments)"
    }
}

extension DetailPageViewController: EntrySelectionDelegate {
    func entrySelected(_ entry: RedditEntry){
        entrySelected = entry
    }
}
