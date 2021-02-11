//
//  GFRepoItemViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/10.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController
{
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems()
    {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub profile")
    }

    override func actionButtonTapped()
    {
        delegate.didTapGitHubProfile(for: user)
    }
}
