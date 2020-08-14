//
//  UserInformationViewController.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 8/13/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }

}
