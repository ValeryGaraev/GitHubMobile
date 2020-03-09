//
//  RepositoriesVC.swift
//  GitHubMobile
//
//  Created by Valery Garaev on 3/10/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import UIKit

class RepositoriesVC: UITableViewController {
    
    var repositories: [Repository]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Repositories"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repositories[indexPath.row].name
        return cell
    }
    
}
