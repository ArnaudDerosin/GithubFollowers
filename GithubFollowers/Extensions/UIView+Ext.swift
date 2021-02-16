//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/16.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

extension UIView
{
    func addSubviews(_ views: UIView...)
    {
        for view in views
        {
            addSubview(view)
        }
    }
}
