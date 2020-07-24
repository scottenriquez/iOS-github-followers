//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/24/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
}
