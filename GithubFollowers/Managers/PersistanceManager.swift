//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/12.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import Foundation

enum PersistanceActionType
{
    case add, remove
}

enum PersistanceManager
{
    static private let defaults = UserDefaults.standard
    
    enum Keys
    {
        static let favorites = "Favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GFError?) -> Void)
    {
        retrieveFavorite { result in
            switch result
            {
                case .success(let favorites):
                    var retrievedFavorites = favorites
                    
                    switch actionType
                    {
                        case .add:
                            guard !retrievedFavorites.contains(favorite) else {
                                completed(.alreadyInFavorites)
                                return
                            }
                            
                            retrievedFavorites.append(favorite)
                        case .remove:
                            retrievedFavorites.removeAll { $0.login == favorite.login }
                    }
                    
                    completed(save(favorites: favorites))
                case .failure(let error):
                    completed(error)
            }
        }
    }
    
    static func retrieveFavorite(completed: @escaping (Result<[Follower], GFError>) -> Void)
    {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        // Decode it into our favorite array
        do
        {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }
        catch
        {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError?
    {
        do
        {
            let encoder = JSONEncoder()
            let encodedFacvorites = try encoder.encode(favorites)
            defaults.set(encodedFacvorites, forKey: Keys.favorites)
            return nil
        }
        catch
        {
            return .unableToFavorite
        }
    }
}
