//
//  PopupBaseController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 11/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PopupBaseController: BaseController {
    var publishSubject = PublishSubject<Void>()
    
    @IBOutlet private weak var contentViewMask: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewMask.addContentDropShadow()
    }
    
    func promptPopup(with rootController: UIViewController? = nil, modalStyle: UIModalPresentationStyle = .overCurrentContext, modalTransition: UIModalTransitionStyle = .crossDissolve) -> PublishSubject<Void> {
        self.modalPresentationStyle = modalStyle
        self.modalTransitionStyle = modalTransition
        
        (rootController ?? NavigationManager.shared.rootController)?.present(self, animated: true, completion: nil)
        return publishSubject
    }
}
