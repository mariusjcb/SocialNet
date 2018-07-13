//
//  ProfileTableViewCell.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 12/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileCell: UITableViewCell {
    enum Nib: String, NibInstantiable {
        case `default` = "ProfileCell"
    }
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func load(user: User) {
        nameLabel.text = (user.lastName ?? "Unknown") + " " + (user.firstName ?? "user")
        
        if let urlString = user.profilePicture?.url, let imageUrl = URL(string: urlString) {
            profileImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "bg_user_profilePicture"))
        } else {
            profileImageView.image = UIImage(named: "bg_user_profilePicture")
        }
    }
}
