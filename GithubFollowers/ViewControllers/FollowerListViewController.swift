//
//  FollowerListViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/28.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController
{
    //----------------------------------------------------------------
    // MARK:- Properties
    //----------------------------------------------------------------
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, pages: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    func configureViewController()
    {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView()
    {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController()
    {
        let searchController                        = UISearchController()
        searchController.searchResultsUpdater       = self
        searchController.searchBar.delegate         = self
        searchController.searchBar.placeholder      = "Search for a username"
        navigationItem.searchController             = searchController
    }
    
    func getFollowers(username: String, pages: Int)
    {
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            self?.dismissLoadingView()
            
            // Unwrapping the optional self
            guard let self = self else { return }
            
            switch result
            {
                case.success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)
                    
                    if self.followers.isEmpty
                    {
                        let message = "This user doesn't have any followers. Go follow them 🤓!"
                        
                        DispatchQueue.main.async
                        {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        
                        return
                    }
                    
                    self.updateData(on: self.followers)
                    
                case.failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    func configureDataSource()
    {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followers: [Follower])
    {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async
        {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


extension FollowerListViewController: UICollectionViewDelegate
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        print("OffsetY = \(offsetY)")
        print("ContentHeight = \(contentHeight)")
        print("Height = \(height)")
        
        if offsetY > contentHeight - height
        {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, pages: page)
        }
    }
}


extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        updateData(on: followers)
    }
}
