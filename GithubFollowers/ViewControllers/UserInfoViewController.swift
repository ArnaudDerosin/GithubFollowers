//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/03.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class
{
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController
{
    //----------------------------------------------------------------
    // MARK:- Properties
    //----------------------------------------------------------------
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlign: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowerListViewController!
    
    
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    func configureVC()
    {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo()
    {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result
            {
                case .success(let user):
                    DispatchQueue.main.async
                    {
                        self.configureUIElements(with: user)
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Somethin went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(with user: User)
    {
        let repoItemVC          = GFRepoItemViewController(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerItemViewController(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub Since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI()
    {
        let padding: CGFloat    = 20
        let itemHeigh: CGFloat  = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews
        {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeigh),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeigh),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView)
    {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC()
    {
        dismiss(animated: true)
    }
}

extension UserInfoViewController: UserInfoViewControllerDelegate
{
    func didTapGitHubProfile(for user: User)
    {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User)
    {
        guard user.followers != 0 else { presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers", buttonTitle: "So sad")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
