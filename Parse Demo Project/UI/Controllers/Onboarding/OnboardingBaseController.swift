//
//  OnboardingBaseController.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit

class OnboardingBaseController: BaseController {
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func hidePageDetailsIfOvercome(position: CGFloat) {
        if position < pageDescriptionLabel.frame.origin.y + pageDescriptionLabel.frame.height {
            pageDescriptionLabel.alpha = 0
        } else {
            pageDescriptionLabel.alpha = 1
        }
        
        if position < pageTitleLabel.frame.origin.y + pageTitleLabel.frame.height {
            pageTitleLabel.alpha = 0
        } else {
            pageTitleLabel.alpha = 1
        }
    }
}
