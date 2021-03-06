//
//  FollowerListViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/28.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

protocol FollowerListViewControllerDelegate: class
{
    func didRequestFollowers(for username: String)
}


class FollowerListViewController: GFDataLoadingViewController
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
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    init(username: String)
    {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title         = username
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
        searchController.searchBar.placeholder      = "Search for a username"
        navigationItem.searchController             = searchController
    }
    
    func getFollowers(username: String, pages: Int)
    {
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            // Unwrapping the optional self
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
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
            
            self.isLoadingMoreFollowers = false
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
    
    @objc func addButtonTapped()
    {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success!", message: "You have succesfully favorited this user", buttonTitle: "Got it!")
                        return
                    }

                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                break
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
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
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, pages: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let activeArray         = isSearching ? filteredFollowers : followers
        let follower            = activeArray[indexPath.item]

        let destinationVC       = UserInfoViewController()
        destinationVC.username  = follower.login
        destinationVC.delegate  = self
        
        let navController       = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}


extension FollowerListViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

extension FollowerListViewController: FollowerListViewControllerDelegate
{
    func didRequestFollowers(for username: String)
    {
        // Get followers for that user
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, pages: page)
    }
}
