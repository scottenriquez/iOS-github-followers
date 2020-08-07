//
//  EmptyStateView.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 8/7/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    let messageLabel = GitHubFollowersTitleLabel(textAlignment: .center, fontSize: 16)
    let emptyLogoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(emptyLogoImageView)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        emptyLogoImageView.image = UIImage(named: "empty-state-logo")
        emptyLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            emptyLogoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyLogoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyLogoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            emptyLogoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
    
}
