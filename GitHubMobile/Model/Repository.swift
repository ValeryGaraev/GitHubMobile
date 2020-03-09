//
//  Repository.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/9/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let name: String
    let owner: Owner
    let repositoryDescription: String?
    let forksCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name, owner
        case repositoryDescription = "description"
        case forksCount = "forks_count"
    }
}

struct Owner: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
