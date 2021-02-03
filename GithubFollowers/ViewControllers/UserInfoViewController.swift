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
    //----------------------------------------------------------------
    // MARK:- Properties
    //----------------------------------------------------------------
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
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result
            {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Somethin went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC()
    {
        dismiss(animated: true)
    }
}
