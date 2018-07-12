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
    private var firstStepsPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.current()!.hasDoneFirstSteps != true && !firstStepsPresented {
            let firstStepController = StoryboardReference.Onboarding.instantiate(viewController: .firstLoginNavigationController)
            present(firstStepController, animated: true)
            
            firstStepsPresented = true
        }
        
        view.setNeedsLayout()
        UIView.animate(withDuration: 0) {
            self.view.alpha = 1
            self.view.layoutSubviews()
        }
    }
    
}
