//
//  RegisterController.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Parse

class RegisterController: OnboardingBaseController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet fileprivate weak var usernameTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    
    @IBOutlet fileprivate weak var sendButton: UILoadButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hidePageDetailsIfOvercome(position: usernameTextField.frame.origin.y)
    }
    
    override func keyboardDidChange(height: CGFloat) {
        self.bottomConstraint?.constant = height + 40
    }
    
    private func didreceiveSignUpResponse(_ success: Bool, _ error: Error?) {
        sendButton.animateOut()
        
        if success {
            let mainController = StoryboardReference.Main.instantiate(viewController: .mainTabBarController)
            NavigationManager.shared.rootController = mainController
        } else {
            Alert.present(withTitle: error!.localizedDescription, rootController: self)
        }
    }
    
    @IBAction func signupDidTap() {
        view.endEditing(true)
        
        let user = User()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        
        user.signUpInBackground(block: didreceiveSignUpResponse)
    }
    
    @IBAction func loginDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
}
