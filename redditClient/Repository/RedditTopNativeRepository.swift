//
//  RedditTopNativeRepository.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 22/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import Foundation

class RedditTopNativeRepository : RedditTopRepository {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    
    func getRedditTopList(completationResponse: @escaping(_ response: [RedditEntry])->Void) {
        
        let baseURL = "https://www.reddit.com/top/.json"

        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: baseURL) {

// TODO: PAGINATION
//          urlComponents.query = ""
            
              guard let url = urlComponents.url else {
                return
              }
              dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                      defer {
                          self?.dataTask = nil
                      }
                      if let error = error {
                        // TODO: ERROR HANDLING

                      } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200 {
                          
                          let decoder = JSONDecoder()
                        decoder.dataDecodingStrategy = .base64
                          
                          do {
                              let redditEntriesResponde = try decoder.decode(RedditEntriesResponse.self, from: data)
                              completationResponse(redditEntriesResponde.children)
                          } catch {
                              
                          }
                      }
            }
            dataTask?.resume()
        }
    }
}
