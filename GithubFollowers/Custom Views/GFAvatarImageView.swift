//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/29.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView
{
    //----------------------------------------------------------------
    // MARK:- Properties
    //----------------------------------------------------------------
    let placeholderImage    = UIImage(named: "avatar-placeholder")!
    let cache               = NetworkManager.shared.cache

    
    //----------------------------------------------------------------
    // MARK:- View Lifecycle Methods
    //----------------------------------------------------------------
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //----------------------------------------------------------------
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    private func configure()
    {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String)
    {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Make sure we don't try to download the image if there is an arror during the call
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            // Set the image to the cache
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async
            {
                self.image = image
            }
        
        }
        
        task.resume()
            
    }
}
