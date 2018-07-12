//
//  ViewController.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse

private enum Segues: String {
    case toMainController = "SegueToMainController"
}

class LoginController: OnboardingBaseController {
    
    @IBOutlet fileprivate weak var usernameTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    
    @IBOutlet fileprivate weak var sendButton: UILoadButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hidePageDetailsIfOvercome(position: usernameTextField.frame.origin.y - 20)
    }
    
    override func keyboardDidChange(height: CGFloat) {
        self.bottomConstraint?.constant = height + 40
    }
    
    func didReceiveLoginResponse(_ user: PFUser?, _ error: Error?) {
        sendButton.animateOut()
        
        if error != nil {
            Alert.present(withTitle: error!.localizedDescription, rootController: self)
        } else {
            let mainController = StoryboardReference.Main.instantiate(viewController: .mainTabBarController)
            NavigationManager.shared.rootController = mainController
        }
    }
    
    @IBAction func loginDidTap() {
        view.endEditing(true)
        User.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: didReceiveLoginResponse)
    }
    
}

