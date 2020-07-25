//
//  GitHubUserSearchTextField.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/20/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class GitHubUserSearchTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label
        textAlignment = .center
        tintColor = .label
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        placeholder = "Enter a username"
        returnKeyType = .search
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
