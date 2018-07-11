//
//  BaseController.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard

class BaseController: UIViewController {
    private var keyboardDisposeBag = DisposeBag()
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeyboardChanges()
    }
    
    func subscribeKeyboardChanges() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] (height) in
                self?.view.setNeedsLayout()
                UIView.animate(withDuration: 0) {
                    self?.keyboardDidChange(height: height)
                    self?.view.layoutIfNeeded()
                }
            }).disposed(by: keyboardDisposeBag)
    }
    
    func unsubscribeKeyboardChanges() {
        keyboardDisposeBag = DisposeBag()
    }
    
    func keyboardDidChange(height: CGFloat) {
        self.bottomConstraint?.constant = -height
    }
}
