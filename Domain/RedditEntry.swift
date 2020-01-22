//
//  RedditEntry.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import Foundation

struct RedditEntry {
    
    let title: String
    let author: String
    let date: Date
    let thumbnailURL: String
    let numberOfComments: Int64
    let unreadStatus: Bool = false

    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum RedditEntryKeys: String, CodingKey {
        case title = "title"
        case author
        case date = "created_utc"
        case thumbnailURL = "thumbnail"
        case numberOfComments = "num_comments"
        case unreadStatus
    }
}

extension RedditEntry: Decodable {
    init(from decoder: Decoder) throws {

        let entryInfo = try decoder.container(keyedBy: CodingKeys.self)

        let data = try entryInfo.nestedContainer(keyedBy: RedditEntryKeys.self, forKey: .data)

        title = try data.decode(String.self, forKey: .title)
        author = try data.decode(String.self, forKey: .author)
        date = try data.decode(Date.self, forKey: .date)
        thumbnailURL = try data.decode(String.self, forKey: .thumbnailURL)
        numberOfComments = try data.decode(Int64.self, forKey: .numberOfComments)
    }
}
