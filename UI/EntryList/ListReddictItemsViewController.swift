//
//  ListReddictItemsViewController.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import UIKit

class ListReddictItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let repository: RedditTopRepository = RedditTopNativeRepository()
    var redditList = [RedditEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.tableView.addSubview(self.refreshControl)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.register(UINib(nibName: "RedditCell", bundle: nil), forCellReuseIdentifier: "redditCell")

        self.refreshData(nil)

    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(ListReddictItemsViewController.refreshData(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    //------------------Refresh Data ----------------------------------//

    func refreshData(_ refreshControl: UIRefreshControl?) {
        self.refreshControl.beginRefreshing()

        repository.getRedditTopList { (data) in
            self.redditList = data
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    
    //--------------TableViewDataSource Protocol----------------------//
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return redditList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditCell", for: indexPath) as! RedditCell
        
        // Configure the cell...
        cell.loadData(self.redditList[indexPath.row])
        
        return cell
    }

}

