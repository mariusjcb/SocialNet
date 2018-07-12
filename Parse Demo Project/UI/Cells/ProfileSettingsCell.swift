//
//  ProfileSettingsCell.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 11/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ProfileSettingsCellDelegate {
    func logoutDidTap()
}

class ProfileSettingsCell: UITableViewCell {
    var delegate: ProfileSettingsCellDelegate?
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var logoutButton: UILoadButton!
    
    func load(user: User, profileImage: UIImage) {
        nameLabel.text = (user.lastName ?? "Unknown") + " " + (user.firstName ?? "User")
        usernameLabel.text = user.username
        
        profileImageView.image = profileImage
    }
    
    @IBAction func logoutDidTap() {
        delegate?.logoutDidTap()
    }
}
