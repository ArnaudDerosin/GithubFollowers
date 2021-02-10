//
//  GFFollowerItemViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/10.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController
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
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
