//
//  SettingsController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 11/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit

private enum CellId: String {
    case profileSettings = "ProfileSettingsCell"
}

class SettingsController: UITableViewController {
    
    @IBOutlet weak var profileSettingsCell: ProfileSettingsCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileSettingsCell.delegate = self
        profileSettingsCell.load(user: User.current()!)
    }
    
}

extension SettingsController: ProfileSettingsCellDelegate {
    func logoutDidTap() {
        User.logOut()
        NavigationManager.shared.rootController = StoryboardReference.Onboarding.instantiate(viewController: .loginController)
    }
}
