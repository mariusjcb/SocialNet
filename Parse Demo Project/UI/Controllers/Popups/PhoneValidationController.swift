//
//  PhoneValidationController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 11/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse
import RxSwift
import RxCocoa

class PhoneValidationController: PopupBaseController {
    private var verificationId: String!
    private var phoneNumber: String!
    
    private var disposeBag = DisposeBag()
    private let currentUser = User.current()!
    
    @IBOutlet fileprivate weak var profileImageView: UIImageView!
    @IBOutlet fileprivate weak var phoneLabel: UILabel!
    @IBOutlet fileprivate weak var codeTextField: UITextField!
    @IBOutlet fileprivate weak var sendButton: UILoadButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneLabel.text = phoneNumber
        currentUser.profilePicture!.rx.requestImage()
            .asObservable()
            .bind(to: profileImageView.rx.image)
            .disposed(by: disposeBag)
        
        codeTextField.rx.text.orEmpty
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
    
    override func keyboardDidChange(height: CGFloat) {
        self.bottomConstraint?.constant = height
    }
    
    func promptValidation(for phoneNumber: String, verificationId: String, rootController: UIViewController) -> PublishSubject<Void> {
        self.phoneNumber = phoneNumber
        self.verificationId = verificationId
        
        return super.promptPopup(with: rootController)
    }
    
    private func savePhoneNumber() {
        currentUser.save(phoneNumber: phoneNumber) { [weak self] success, error in
            self?.sendButton.animateOut()
            if success {
                self?.publishSubject.onNext(())
            } else {
                self?.publishSubject.onError(error!)
                Alert.present(withTitle: error!.localizedDescription, rootController: self)
            }
            
            self?.publishSubject.onCompleted()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func sendDidTap() {
        view.endEditing(true)
        
        let verificationCode = codeTextField.text!
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
        
        Auth.auth().signInAndRetrieveData(with: credential) { [weak self] (authResult, error) in
            if let error = error {
                self?.sendButton.animateOut()
                self?.publishSubject.onError(error)
                self?.publishSubject.onCompleted()
                
                Alert.present(withTitle: error.localizedDescription, rootController: self)
                self?.dismiss(animated: false, completion: nil)
                
                return
            }
            
            self?.savePhoneNumber()
        }
    }
}
