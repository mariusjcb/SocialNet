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
    
    func promptPopup(with rootController: UIViewController? = nil, modalStyle: UIModalPresentationStyle = .overCurrentContext, modalTransition: UIModalTransitionStyle = .crossDissolve) -> PublishSubject<Void> {
        self.modalPresentationStyle = modalStyle
        self.modalTransitionStyle = modalTransition
        
        (rootController ?? NavigationManager.shared.rootController)?.present(self, animated: true, completion: nil)
        return publishSubject
    }
    
    private func addContentDropShadow() {
        self.contentViewMask.layer.shadowPath = UIBezierPath(roundedRect:
            self.contentViewMask.bounds, cornerRadius: self.contentViewMask.layer.cornerRadius).cgPath
        self.contentViewMask.layer.shadowColor = UIColor.black.cgColor
        self.contentViewMask.layer.shadowOpacity = 0.3
        self.contentViewMask.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.contentViewMask.layer.shadowRadius = 5
        self.contentViewMask.layer.masksToBounds = false
    }
}
