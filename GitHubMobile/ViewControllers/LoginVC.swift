//
//  LoginVC.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/7/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import UIKit
import WebKit

class LoginVC: UIViewController, WKNavigationDelegate {
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        self.present(GitHubVC(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
}

