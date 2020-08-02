//
//  GitHubAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/30/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class GitHubAvatarImageView: UIImageView {
    
    let cache = NSCache<NSString, UIImage>()
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
    
    func downloadAvatarImage(at urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        guard let avatarImageURL = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: avatarImageURL) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            if error != nil {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let data = data else {
                return
            }
            guard let avatarImage = UIImage(data: data) else { return }
            self.cache.setObject(avatarImage, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = avatarImage
            }
        }
        task.resume()
    }
    
}
