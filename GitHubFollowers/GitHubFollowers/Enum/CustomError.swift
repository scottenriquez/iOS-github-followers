//
//  CustomError.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/28/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import Foundation

enum CustomError: String, Error {
    case invalidURL = "The URL generated is invalid"
    case networkFailure = "An error occurred when making the network call"
    case invalidHTTPResponse = "The server returned an invalid response or status code"
    case dataReadFailure = "An error occured when reading the data"
    case decodingFailure = "An error occured when decoding the JSON response"
}
