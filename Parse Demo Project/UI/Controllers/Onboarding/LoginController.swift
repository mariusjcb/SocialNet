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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = User.getCurrentUserInBackground()
        task.continueOnSuccessWith { [weak self] (userTask) -> Any? in
            if userTask.isCompleted {
                DispatchQueue.main.async {
                    self?.didReceiveLoginResponse(userTask.result, nil)
                }
            }
            
            return nil
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hidePageDetailsIfOvercome(position: usernameTextField.frame.origin.y)
    }
    
    override func keyboardDidChange(height: CGFloat) {
        self.bottomConstraint?.constant = height + 40
    }
    
    func didReceiveLoginResponse(_ user: PFUser?, _ error: Error?) {
        sendButton.animateOut()
        
        if error != nil {
            Alert.present(withTitle: error!.localizedDescription)
        } else {
            let mainController = StoryboardReference.Main.instantiate(viewController: .mainTabBarController)
            NavigationManager.shared.rootController = mainController
        }
    }
    
    @IBAction func loginDidTap() {
        User.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: didReceiveLoginResponse)
    }
    
}

