//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/28.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel
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
    
    init(textAlignement: NSTextAlignment)
    {
        super.init(frame: .zero)
        self.textAlignment                          = textAlignment
        configure()
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    private func configure()
    {
        textColor                                   = .secondaryLabel
        font                                        = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.75
        lineBreakMode                               = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
