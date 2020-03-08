//
//  GitHubConstants.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/7/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import Foundation

struct GitHubConstants {
    static let CLIENT_ID = "e6eb18160c900ce6cf2a"
    static let CLIENT_SECRET = "993adea4920708d7ef35035832ce549d9ebd7520"
    static let REDIRECT_URI = "http://localhost:4567/callback"
    static let SCOPE = "read:user,user:email"
    static let TOKENURL = "https://github.com/login/oauth/access_token"
}
