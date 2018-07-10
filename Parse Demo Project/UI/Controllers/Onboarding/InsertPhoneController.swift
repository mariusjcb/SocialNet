//
//  InsertPhoneController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 10/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse
import RxSwift
import RxCocoa

class InsertPhoneController: BaseController {
    private var disposeBag = DisposeBag()
    private let currentUser = User.current()!
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var profileImageView: UIImageView!
    @IBOutlet fileprivate weak var phoneNumberTextField: UITextField!
    @IBOutlet fileprivate weak var sendButton: UILoadButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = currentUser.lastName! + " " + currentUser.firstName!
        currentUser.profilePicture!.rx.requestImage
            .asObservable()
            .bind(to: profileImageView.rx.image)
            .disposed(by: disposeBag)
        
        phoneNumberTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .bind(to: sendButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    @IBAction private func sendDidTap() {
        let phoneNumber = phoneNumberTextField.text!
        
        do {
            try currentUser.save(phoneNumber: phoneNumber) { [weak self] _, _ in
                self?.sendButton.animateOut()
            }
        } catch {
            sendButton.animateOut()
            Alert.present(withTitle: error.localizedDescription)
        }
    }
}
