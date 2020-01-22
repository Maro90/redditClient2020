//
//  RedditCell.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import UIKit

class RedditCell: UITableViewCell {

    @IBOutlet var titleLabel:       UILabel!
    @IBOutlet var authorLabel:      UILabel!
    @IBOutlet var dateLabel:        UILabel!
    @IBOutlet var imageThumbnail:   UIImageView!
    @IBOutlet var numberOfComments:     UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadData(_ data: RedditEntry){
        
        self.titleLabel.text = data.title
        self.authorLabel.text = data.author

        if let image = data.thumbnailURL {
            let url = URL(string: image)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
