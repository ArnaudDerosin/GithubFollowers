//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/03.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView
{
    //----------------------------------------------------------------
    // MARK:- Properties
    //----------------------------------------------------------------
    let messageLabel    = GFTitleLabel(textAlign: .center, fontSize: 28)
    let logoImageView   = UIImageView()

    
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
    
    init(message: String)
    {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    private func configure()
    {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        logoImageView.image         = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
