//
//  Follower.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/01/28.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable
{
    var login: String
    var avatarUrl: String
}
