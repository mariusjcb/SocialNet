//
//  SuccessPopupController.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 11/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import RxSwift

class SuccessPopupController: PopupBaseController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func subscribeKeyboardChanges() {
        print("Keyboard interactions disabled on success popup")
    }
    
    override func unsubscribeKeyboardChanges() {
        print("Keyboard interactions disabled on success popup")
    }
    
    func promptSuccess(message: String, title: String, rootController: UIViewController? = nil) -> PublishSubject<Void> {
        self.titleLabel.text = title
        self.descriptionLabel.text = message
        
        return promptPopup()
    }
    
    @IBAction func successDidTap() {
        publishSubject.onNext(())
        publishSubject.onCompleted()
        
        dismiss(animated: true, completion: nil)
    }
}
