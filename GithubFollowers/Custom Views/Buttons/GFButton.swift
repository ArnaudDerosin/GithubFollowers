//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/27.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFButton: UIButton
{
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    // Used when you create the view programmatically.
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configure()
    }
    
    // Used when the view is created from storyboard/xib.
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String)
    {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    // Can only be called in this class, set up the look of the button
    private func configure()
    {
        layer.cornerRadius                          = 10
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    func set(backgroundColor: UIColor, title: String)
    {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
