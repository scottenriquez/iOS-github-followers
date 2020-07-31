//
//  GitHubFollowerCollectionViewCell.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/30/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class GitHubFollowerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    let defaultPadding: CGFloat = 8
    let avatarImageView = GitHubAvatarImageView(frame: .zero)
    let usernameLabel = GitHubFollowersTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapFollowerData(for follower: GitHubFollower) {
        usernameLabel.text = follower.login
        
    }
    
    func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultPadding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultPadding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultPadding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultPadding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
