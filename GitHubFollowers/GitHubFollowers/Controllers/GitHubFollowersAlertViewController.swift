//
//  GitHubFollowersAlertViewController.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/25/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class GitHubFollowersAlertViewController: UIViewController {

    let containerView = UIView()
    let titleLabel = GitHubFollowersTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GitHubFollowersBodyLabel(textAlignment: .center)
    let alertButton = GitHubFollowersButton(backgroundColor: .systemPink, title: "Ok")
    let defaultPadding: CGFloat = 20
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureAlertButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.widthAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong..."
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: defaultPadding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -defaultPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureAlertButton() {
        containerView.addSubview(alertButton)
        alertButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        alertButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        NSLayoutConstraint.activate([
            alertButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -defaultPadding),
            alertButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: defaultPadding),
            alertButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -defaultPadding),
            alertButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "An unknown error has occurred"
        messageLabel.numberOfLines = 4
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: defaultPadding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -defaultPadding)
        ])
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
}
