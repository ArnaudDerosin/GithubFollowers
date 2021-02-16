//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/28.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel
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
    
    convenience init(textAlign: NSTextAlignment, fontSize: CGFloat)
    {
        self.init(frame: .zero)
        self.textAlignment  = textAlign
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    private func configure()
    {
        textColor                                   = .label
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.9
        lineBreakMode                               = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
