//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/27/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/"
    let pageSize = 100
    
    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, completionHandler: @escaping ([GitHubFollower]?, String?) -> Void) {
        let followersURLString = baseURL + "users/\(username)/followers?per_page=\(pageSize)&page=\(page)"
        guard let followersURL = URL(string: followersURLString) else {
            completionHandler(nil, "The username supplied creates an invalid HTTP request")
            return
        }
        let task = URLSession.shared.dataTask(with: followersURL) { (data, response, error) in
            if let _ = error {
                completionHandler(nil, "An error occurred when making a network call")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, "The server returned an invalid response")
                return
            }
            guard let data = data else {
                completionHandler(nil, "An error occured when reading the data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([GitHubFollower].self, from: data)
                completionHandler(followers, nil)
            }
            catch {
                completionHandler(nil, "An error occured when decoding the JSON response")
            }
        }
        task.resume()
    }
    
}
