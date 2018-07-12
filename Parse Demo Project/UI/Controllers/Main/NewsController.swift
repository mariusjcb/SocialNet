//
//  NewsController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 12/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse

private let ProfileCellID = "ProfileCell"

class NewsController: UIViewController {
    private var fetchedUsers = [User]()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchDisplayController?.searchResultsTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileCellID)
    }
}

extension NewsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filterFormat = "(\(\User.firstName) LIKE '*%1$@*' OR \(\User.lastName) LIKE '*%1$@*'"
        let query = User.query(with: NSPredicate(format: filterFormat, searchText))
    }
}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellID, for: indexPath) as! ProfileTableViewCell
        cell.load(name: <#T##String#>, image: <#T##UIImage#>)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedUsers.count
    }
}

