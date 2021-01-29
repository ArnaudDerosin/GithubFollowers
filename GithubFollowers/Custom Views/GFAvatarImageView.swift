//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/29.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView
{
    //----------------------------------------------------------------
    // MARK:- Properties
    //----------------------------------------------------------------
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    private func configure()
    {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
