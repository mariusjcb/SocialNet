//
//  MainTabBarController.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse

class MainTabBarController: UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.current()!.isFirstLogin {
            let firstStepController = StoryboardReference.Onboarding.instantiate(viewController: .firstLoginNavigationController)
            firstStepController.modalPresentationStyle = .overCurrentContext
            
            present(firstStepController, animated: true)
        }
    }
    
}
