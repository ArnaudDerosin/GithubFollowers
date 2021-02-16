//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/15.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController
{
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers                 = [createSearchNC(), createFavoritesNC()]
    }
    

    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    func createSearchNC() -> UINavigationController
    {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController
    {
        let favoritesListVC = FavoritesListViewController()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
}
