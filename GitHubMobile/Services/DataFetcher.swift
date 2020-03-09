//
//  DataFetcher.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/8/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import Foundation

enum FetchingError: Error {
    case fetchingError
    case responseError
    case decodingError
}

struct DataFetcher {
    func fetchRepositories(accessToken: String, completion: @escaping (Result<[Repository], FetchingError>) -> Void) {
        let urlString = "https://api.github.com/user/repos"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(.failure(.responseError))
                return
            }
            guard let repositories = try? JSONDecoder().decode([Repository].self, from: data) else { return }
            completion(.success(repositories))
        }
        task.resume()
    }
}
