//
//  ProfileDataFetcher.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/8/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import Foundation

struct ProfileDataFetcher {
    
    func fetchGitHubUserProfile(accessToken: String) {
        let urlString = "https://api.github.com/user"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable : Any]
        }
        task.resume()
    }
    
}
