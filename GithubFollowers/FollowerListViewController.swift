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
    var username: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
//        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
