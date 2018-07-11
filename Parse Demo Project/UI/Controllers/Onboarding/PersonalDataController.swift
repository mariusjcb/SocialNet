//
//  PersonalDataController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 10/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse
import RxSwift
import RxCocoa

private enum Segues: String {
    case toInsertPhoneNumber = "segueToInsertPhoneNumber"
}

class PersonalDataController: BaseController, UINavigationControllerDelegate {
    private var disposeBag = DisposeBag()
    
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var profileImageView: UIImageView!
    @IBOutlet fileprivate weak var firstNameTextField: UITextField!
    @IBOutlet fileprivate weak var lastNameTextField: UITextField!
    @IBOutlet fileprivate weak var continueButton: UILoadButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = User.current()!.username
        enableButtonActivation()
    }
    
    private func enableButtonActivation() {
        let firstNameValidation = firstNameTextField.rx.text.orEmpty
            .map { $0.count > 3 }
            .share()
        
        let lastNameValidation = lastNameTextField.rx.text.orEmpty
            .map { $0.count > 3 }
            .share()
        
        let buttonActivator = Observable.combineLatest(firstNameValidation, lastNameValidation) { hasFirstName, hasLastName -> Bool in
            return hasFirstName && hasLastName
        }
        
        buttonActivator
            .do(onNext: { active in
                if active {
                    self.continueButton.backgroundColor = .buttonEnabledColor
                } else {
                    self.continueButton.backgroundColor = .buttonDisabledColor
                }
            })
            .bind(to: continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    @IBAction private func changeImageDidTap() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        Alert.present(withTitle: "Select source type", style: .actionSheet, rootController: self, actions: [
            "Camera": { (alert) in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true)
            },
            "Photo Library": { (alert) in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true)
            }
        ])
    }
    
    @IBAction private func continueDidTap() {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let profileImage = profileImageView.image!
        
        User.current()?.save(firstName: firstName, lastName: lastName, profilePicture: profileImage) { [weak self] success, error in
            self?.continueButton.animateOut()
            
            if success {
                self?.performSegue(withIdentifier: Segues.toInsertPhoneNumber.rawValue, sender: nil)
            } else {
                Alert.present(withTitle: error!.localizedDescription, rootController: self)
            }
        }
    }
}

extension PersonalDataController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
