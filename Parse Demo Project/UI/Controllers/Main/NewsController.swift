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
    fileprivate var searching = false
    fileprivate var fetchedUsers = [User]()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(ProfileCell.Nib.instantiate(.default), forCellReuseIdentifier: ProfileCellID)
    }
}

extension NewsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searching else { return }
        
        fetchedUsers = [User]()
        searching = true
        
        try? User.query([
                .firstName: .containsAll(searchText),
                .lastName: .containsAll(searchText)
            ]).findObjectsInBackground(block: { [weak self] (success, error) in
                self?.searching = false
                
                guard let users = success as? [User] else {
                    Alert.present(withTitle: error!.localizedDescription, rootController: self)
                    return
                }
                
                self?.fetchedUsers = users
                self?.tableView.reloadData()
            })
    }
}

extension NewsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = fetchedUsers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellID, for: indexPath) as! ProfileCell
        cell.load(user: user)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedUsers.count
    }
}

