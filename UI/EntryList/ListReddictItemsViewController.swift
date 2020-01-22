//
//  ListReddictItemsViewController.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import UIKit

class ListReddictItemsViewController: UITableViewController {
    
    let repository: RedditTopRepository = RedditTopNativeRepository()
    var redditList = [RedditEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.register(UINib(nibName: "RedditCell", bundle: nil), forCellReuseIdentifier: "redditCell")

        refreshData(self.refreshControl)
    }
    
    //------------------Refresh Data ----------------------------------//
    @IBAction func refreshData(_ sender: UIRefreshControl?) {
            sender?.beginRefreshing()

            repository.getRedditTopList { [weak self] (data) in
                self?.redditList = data
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            }
    }

    //--------------TableViewDataSource Protocol----------------------//
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return redditList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditCell", for: indexPath) as! RedditCell
        
        // Configure the cell...
        cell.loadData(self.redditList[indexPath.row])
        
        return cell
    }

}

