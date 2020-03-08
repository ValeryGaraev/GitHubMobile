//
//  GitHubVC.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/7/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import UIKit
import WebKit
import SwiftKeychainWrapper

class GitHubVC: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    let url = URL(string: "https://github.com/login/oauth/authorize?client_id=" + GitHubConstants.CLIENT_ID + "&scope=" + GitHubConstants.SCOPE + "&redirect_uri=" + GitHubConstants.REDIRECT_URI + "&state=" + UUID().uuidString)
    var networkService: AuthService!
    
    override func loadView() {
        networkService = AuthService()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gitHubRequest = URLRequest(url: url!)
        webView.load(gitHubRequest)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        networkService.requestAccessToken(request: navigationAction.request) { result in
            switch result {
            case .success(let accessToken):
                let saved = KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        decisionHandler(.allow)
    }
    
}
