//
//  GitHubUser.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/25/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import Foundation

struct GitHubUser: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlURL: String
    var following: Int
    var followers: Int
    var createdAt: String
}
