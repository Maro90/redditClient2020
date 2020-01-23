//
//  ListViewModel.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 23/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import Foundation

protocol ListViewModelDelegate {
    func reloadEntries(completation: @escaping(()->Void))
    func selectEntry(entry: RedditEntry)
    func getSelectedEntry() -> RedditEntry?
    func getEntries() -> [RedditEntry]
    func getEntryFor(index: Int) -> RedditEntry?
    func getEntriesCount() -> Int
}

class ListViewModel: ListViewModelDelegate {
    let repository: RedditTopRepository = RedditTopNativeRepository()
    var redditList = [RedditEntry]()

    var selectedEntry: RedditEntry?
    
    func reloadEntries(completation: @escaping(()->Void)) {
        repository.getRedditTopList { [weak self] (data) in
            self?.redditList = data
            completation()
        }
    }
    
    func selectEntry(entry: RedditEntry) {
        self.selectedEntry = entry
    }
    
    func getSelectedEntry() -> RedditEntry? {
        guard let entry = selectedEntry else {
            return redditList.first
        }
        return entry
    }
    
    func getEntries() -> [RedditEntry] {
        return redditList
    }
    
    func getEntryFor(index: Int) -> RedditEntry? {
        guard index >= 0 && index < redditList.count else {
            return nil
        }
        return redditList[index]
    }
    
    func getEntriesCount() -> Int {
        return redditList.count
    }
}
