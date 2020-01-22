//
//  RedditEntriesResponse.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import Foundation

struct RedditEntriesResponse {
    let children: [RedditEntry]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum RedditEntriesResponseKeys: String, CodingKey {
        case children
    }
}

extension RedditEntriesResponse: Decodable {
    init(from decoder: Decoder) throws {

        let entriesResponse = try decoder.container(keyedBy: CodingKeys.self)

        let data = try entriesResponse.nestedContainer(keyedBy: RedditEntriesResponseKeys.self, forKey: .data)

        children = try data.decode([RedditEntry].self, forKey: .children)
    }
}
