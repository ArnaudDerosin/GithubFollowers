//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/29.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell
{
    //----------------------------------------------------------------
    // MARK:- Properties
    //----------------------------------------------------------------
    static let reuseID      = "FollowerCell"
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlign: .center, fontSize: 16)
    
    
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    func set(follower: Follower)
    {
        usernameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async
            {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func configure()
    {
        addSubviews(avatarImageView, usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
