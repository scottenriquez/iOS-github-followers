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
    var isSearching = false
    var gitHubFollowers: [GitHubFollower] = []
    var filteredGitHubFollowers: [GitHubFollower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, GitHubFollower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
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
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
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
                self.updateData(with: self.gitHubFollowers)
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
    
    func updateData(with followers: [GitHubFollower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, GitHubFollower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredGitHubFollowers : gitHubFollowers
        let follower = activeArray[indexPath.item]
        let destinationViewController = UserInformationViewController()
        destinationViewController.username = follower.login
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        present(navigationController, animated: true)
    }
    
}

extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredGitHubFollowers = gitHubFollowers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(with: filteredGitHubFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(with: gitHubFollowers)
    }
    
}
