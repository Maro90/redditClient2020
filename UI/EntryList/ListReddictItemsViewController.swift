//
//  ListReddictItemsViewController.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import UIKit

class ListReddictItemsViewController: UITableViewController {
    
    var viewModel: ListViewModelDelegate?

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
        viewModel?.reloadEntries(completation: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        })
    }

    //--------------TableViewDataSource Protocol----------------------//
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return viewModel?.getEntriesCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditCell", for: indexPath) as! RedditCell
        
        if let entry = viewModel?.getEntryFor(index: indexPath.row) {
            cell.loadData(entry)
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let entry = viewModel?.getEntryFor(index: indexPath.row),
            let splitController = splitViewController as? ListSplitViewController {
            
            viewModel?.selectEntry(entry: entry)
            splitController.presentDetailViewController()
        }
    }
}

