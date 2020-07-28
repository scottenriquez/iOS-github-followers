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
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let customError):
                self.presentGitHubFollowersAlertOnMainThread(alertTitle: "Network Error", message: customError.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
