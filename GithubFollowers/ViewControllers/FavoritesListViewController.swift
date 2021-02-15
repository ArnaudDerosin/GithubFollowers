//
//  FavoritesListViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/27.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController
{
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        PersistanceManager.retrieveFavorites { result in
            switch result
            {
                case .success(let favorites):
                    print(favorites)
                case .failure(let error):
                    break
            }
        }
    }
}
