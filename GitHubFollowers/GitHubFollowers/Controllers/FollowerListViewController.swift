//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 7/24/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

    enum Section {
        case main
    }
    
    var username: String!
    var gitHubFollowers: [GitHubFollower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, GitHubFollower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureUICollectionViewDataSource()
        fetchGitHubFollowersForEnteredUsername()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: FlowLayoutHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GitHubFollowerCollectionViewCell.self, forCellWithReuseIdentifier: GitHubFollowerCollectionViewCell.reuseID)
    }
    
    func fetchGitHubFollowersForEnteredUsername() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                self.gitHubFollowers = followers
                self.updateData()
            case .failure(let customError):
                self.presentGitHubFollowersAlertOnMainThread(alertTitle: "Network Error", message: customError.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUICollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, GitHubFollower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, gitHubFollower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GitHubFollowerCollectionViewCell.reuseID, for: indexPath) as! GitHubFollowerCollectionViewCell
            cell.mapFollowerData(for: gitHubFollower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, GitHubFollower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(gitHubFollowers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
