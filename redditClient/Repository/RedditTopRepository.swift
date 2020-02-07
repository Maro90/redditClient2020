//
//  RedditTopRepository.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import Foundation

protocol RedditTopRepository {
    func getRedditTopList(completationResponse: @escaping(_ response: [RedditEntry])->Void)
}
