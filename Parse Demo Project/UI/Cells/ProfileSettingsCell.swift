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
    
    private var disposeBag: DisposeBag!
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var logoutButton: UILoadButton!
    
    func load(user: User) {
        nameLabel.text = user.lastName! + " " + user.firstName!
        usernameLabel.text = user.username!
        
        disposeBag = DisposeBag()
        user.profilePicture!.rx.requestImage()
            .subscribe(onSuccess: { [weak self] image in
                self?.profileImageView.image = image
            }).disposed(by: disposeBag)
    }
    
    @IBAction func logoutDidTap() {
        delegate?.logoutDidTap()
    }
}
