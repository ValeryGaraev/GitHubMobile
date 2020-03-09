//
//  NetworkService.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/7/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
}

protocol Auth {
    func requestAccessToken(request: URLRequest, completion: @escaping (Result<String, APIError>) -> Void)
}

class AuthService: Auth {
    
    func requestAccessToken(request: URLRequest, completion: @escaping (Result<String, APIError>) -> Void) {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.contains("code="), let range = requestURLString.range(of: "=") {
            let authCode = requestURLString[range.upperBound...]
            if let range = authCode.range(of: "&state=") {
                let authCode = String(authCode[..<range.lowerBound])
                requestAccessToken(authCode: authCode) { result in
                    switch result {
                    case .success(let serverResponse):
                        let accessToken = serverResponse["access_token"] as! String
                        completion(.success(accessToken))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    private func requestAccessToken(authCode: String, completion: @escaping (Result<[AnyHashable : Any], APIError>) -> Void) {
        
        let grantType = "authorization_code"
        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + GitHubConstants.CLIENT_ID + "&client_secret=" + GitHubConstants.CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        
        guard let url = URL(string: GitHubConstants.TOKENURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, _ in
            guard let data = data, (response as! HTTPURLResponse).statusCode == 200 else {
                completion(.failure(.responseProblem))
                return
            }
            guard let results = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable : Any] else {
                completion(.failure(.decodingProblem))
                return
            }
            completion(.success(results))
        }
        task.resume()
    }
}
