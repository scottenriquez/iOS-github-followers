//
//  UIViewControllerExtension.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/25/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentGitHubFollowersAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GitHubFollowersAlertViewController(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
}
