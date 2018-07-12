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
    
    private var currentUser: User? {
        do {
            return try User.rx.currentUser.value()
        } catch {
            return nil
        }
    }
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var profileImageView: UIImageView!
    @IBOutlet fileprivate weak var phoneNumberTextField: UITextField!
    @IBOutlet fileprivate weak var sendButton: UILoadButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = (currentUser?.lastName ?? "Unknown") + " " + (currentUser?.firstName! ?? "user")
        currentUser?.profilePicture!.rx.requestImage()
            .asObservable()
            .bind(to: profileImageView.rx.image)
            .disposed(by: disposeBag)
        
        phoneNumberTextField.placeholder = currentUser?.phone ?? "Phone Number"
        phoneNumberTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .do(onNext: { active in
                if active {
                    self.sendButton.backgroundColor = .buttonEnabledColor
                } else {
                    self.sendButton.backgroundColor = .buttonDisabledColor
                }
            })
            .bind(to: sendButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func registerFirstUserLogin() {
        currentUser?.hasDoneFirstSteps = true
        currentUser?.saveEventually()
        
        let successPopup = StoryboardReference.Popups.instantiate(viewController: .successPopupController) as! SuccessPopupController
        successPopup.promptPopup()
            .dispose()
    }
    
    private func sendVerificationCode() {
        let phoneNumber = phoneNumberTextField.text!
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
            self?.sendButton.animateOut()
            
            if let error = error {
                Alert.present(withTitle: error.localizedDescription, rootController: self)
                return
            }
            
            self?.validatePhoneNumber(withId: verificationID!)
        }
    }
    
    private func validatePhoneNumber(withId verificationId: String) {
        let phoneNumber = phoneNumberTextField.text!
        let validationPopup = StoryboardReference.Popups.instantiate(viewController: .phoneValidationController) as! PhoneValidationController
        
        unsubscribeKeyboardChanges()
        validationPopup.promptValidation(for: phoneNumber, verificationId: verificationId, rootController: self)
            .subscribe(onNext: { [weak self] in
                self?.subscribeKeyboardChanges()
                
                let handler = self?.registerFirstUserLogin
                self?.dismiss(animated: true, completion: handler)
            }).disposed(by: disposeBag)
    }
    
    @IBAction private func sendDidTap() {
        view.endEditing(true)
        
        let phoneNumber = phoneNumberTextField.text!
        guard phoneNumber != currentUser?.phone else {
            sendButton.animateOut()
            Alert.present(withTitle: "The old phone number is also your new number? Mhm, Nice.", rootController: self)
            
            return
        }
        
        User.query()?.whereKey(#keyPath(User.phone), equalTo: phoneNumber)
            .findObjectsInBackground(block: { [weak self] objects, error in
                if objects != nil {
                    self?.sendButton.animateOut()
                    Alert.present(withTitle: "Phone number taken. Please insert another one.", rootController: self)
                } else {
                    self?.sendVerificationCode()
                }
            })
    }
}
