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
    var currentPage = 1
    var userHasMoreFollowers = true
    var gitHubFollowers: [GitHubFollower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, GitHubFollower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureUICollectionViewDataSource()
        fetchGitHubFollowers(for: username, page: currentPage)
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
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GitHubFollowerCollectionViewCell.self, forCellWithReuseIdentifier: GitHubFollowerCollectionViewCell.reuseID)
    }
    
    func fetchGitHubFollowers(for username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followersForCurrentPage):
                self.userHasMoreFollowers = followersForCurrentPage.count == 100
                self.gitHubFollowers.append(contentsOf: followersForCurrentPage)
                if self.gitHubFollowers.isEmpty {
                    let message = "This user doesn't have any followers. You should follow them!"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                }
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

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard userHasMoreFollowers else { return }
            currentPage += 1
            fetchGitHubFollowers(for: username, page: currentPage)
        }
    }
    
}
