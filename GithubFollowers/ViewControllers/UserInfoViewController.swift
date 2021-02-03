//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/03.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController
{
    var username: String!
    
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC()
    {
        dismiss(animated: true)
    }
}
