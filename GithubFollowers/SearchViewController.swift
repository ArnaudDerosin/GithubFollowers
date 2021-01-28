//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/27.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController
{
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Properties
    //----------------------------------------------------------------
    let logoImageView       = UIImageView()
    let userNameTextField   = GFTextField()
    let callToActionButton  = GFButton(backgroundColor: .systemBlue, title: "Get Followers")
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        // Hide the navigation bar everytime the view is showed
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    func configureLogoImageView()
    {
        // Equivalent of grabbing a UIImageView, dragging it to the ViewController and dropping it (with Storyboard)
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints     = false
        logoImageView.image                                         = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField()
    {
        view.addSubview(userNameTextField)

        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton()
    {
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
