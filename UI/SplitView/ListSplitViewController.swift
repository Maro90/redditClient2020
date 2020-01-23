//
//  ListSplitViewController.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import UIKit

protocol EntrySelectionDelegate: UIViewController {
  func entrySelected(_ entry: RedditEntry)
}

class ListSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    var viewModel: ListViewModelDelegate = ListViewModel()
    var detailViewController: EntrySelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }

    func splitViewController(
             _ splitViewController: UISplitViewController,
             collapseSecondary secondaryViewController: UIViewController,
             onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
    
    func presentDetailViewController() {
        guard let detailPageViewController = detailViewController,
            let entry = viewModel.getSelectedEntry() else {
                return
        }
        detailPageViewController.entrySelected(entry)
        self.showDetailViewController(detailPageViewController, sender: nil)
    }
}
