//
//  GitHubAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/30/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class GitHubAvatarImageView: UIImageView {
    
    let avatarPlaceholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = avatarPlaceholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
