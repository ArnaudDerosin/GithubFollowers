//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/03.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel
{
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
    
    init(fontSize: CGFloat)
    {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    private func configure()
    {
        textColor                                   = .secondaryLabel
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.90
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
