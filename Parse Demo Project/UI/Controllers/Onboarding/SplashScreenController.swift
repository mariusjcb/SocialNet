//
//  SplashScreenController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 12/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse

private enum Segues: String {
    case toLoginController = "segueToLoginNavigationController"
    case toMainScreen = "segueToMainScreen"
}

class SplashScreenController: OnboardingBaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = User.getCurrentUserInBackground()
        task.continueOnSuccessWith { (userTask) -> Any? in
            if userTask.isCompleted {
                guard let user = userTask.result else {
                    self.perform(segue: .toLoginController)
                    return nil
                }
                
                do {
                    try user.fetch()
                } catch {
                    self.showMessage(error.localizedDescription)
                    self.perform(segue: .toLoginController)
                }
            }
            
            self.perform(segue: .toMainScreen)
            return nil
        }
    }
    
    private func perform(segue: Segues) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: segue.rawValue, sender: nil)
        }
    }
    
    private func showMessage(_ message: String) {
        DispatchQueue.main.async {
            Alert.present(withTitle: message)
        }
    }
}
