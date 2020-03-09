//
//  LoginVC.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/7/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import UIKit
import WebKit
import SwiftKeychainWrapper

class LoginVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        if let _: String = KeychainWrapper.standard.string(forKey: "accessToken") {
            self.performSegue(withIdentifier: "repositoriesSegue", sender: self)
        } else {
            self.present(GitHubVC(), animated: true, completion: nil)
        }
    }
    
    var repositories: [Repository]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        
        let dataFetcher = DataFetcher()
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "accessToken") else { return }
        dataFetcher.fetchRepositories(accessToken: accessToken) { (result) in
            // print(result)
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "repositoriesSegue", sender: self)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repositoriesSegue" {
            let destination = segue.destination as! RepositoriesVC
            destination.repositories = self.repositories
        }
    }
    
    private func setup() {
        if let _: String = KeychainWrapper.standard.string(forKey: "accessToken") {
            logInButton.setTitle("Show repositories", for: .normal)
        }
    }
    
}

