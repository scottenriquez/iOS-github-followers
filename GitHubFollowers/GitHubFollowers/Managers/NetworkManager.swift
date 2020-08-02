//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/27/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/"
    private let pageSize = 100

    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, completionHandler: @escaping (Result<[GitHubFollower], CustomError>) -> Void) {
        let followersURLString = baseURL + "users/\(username)/followers?per_page=\(pageSize)&page=\(page)"
        guard let followersURL = URL(string: followersURLString) else {
            completionHandler(.failure(CustomError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: followersURL) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure(CustomError.networkFailure))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(CustomError.invalidHTTPResponse))
                return
            }
            guard let data = data else {
                completionHandler(.failure(CustomError.dataReadFailure))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([GitHubFollower].self, from: data)
                completionHandler(.success(followers))
            }
            catch {
                completionHandler(.failure(CustomError.decodingFailure))
            }
        }
        task.resume()
    }
    
}
