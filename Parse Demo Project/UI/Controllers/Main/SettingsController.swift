//
//  SettingsController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 11/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import RxSwift

private enum CellId: String {
    case profileSettings = "ProfileSettingsCell"
}

class SettingsController: UITableViewController {
    private var volatileDisposeBag = DisposeBag()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var profileSettingsCell: ProfileSettingsCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileSettingsCell.delegate = self
        
        User.rx.currentUser.subscribe(onNext: { [weak self] (user) in
            self?.volatileDisposeBag = DisposeBag()
            self?.loadProfileCell(for: user)
        }).disposed(by: disposeBag)
    }
    
    private func loadProfileCell(for user: User?) {
        guard let user = user else {
            return
        }
        
        user.profilePicture?.rx.requestImage()
            .subscribe(onSuccess: { [weak self] image in
                self?.profileSettingsCell.load(user: user, profileImage: image)
            }).disposed(by: volatileDisposeBag)
    }
    
}

extension SettingsController: ProfileSettingsCellDelegate {
    func logoutDidTap() {
        User.logOut()
        NavigationManager.shared.rootController = StoryboardReference.Onboarding.instantiate(viewController: .loginNavigationController)
    }
}
