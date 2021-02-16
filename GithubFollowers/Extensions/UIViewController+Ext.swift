//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/28.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController
{
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String)
    {
        DispatchQueue.main.async
        {
            let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL)
    {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
