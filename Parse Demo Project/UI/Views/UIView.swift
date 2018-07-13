//
//  UIView.swift
//  SUB Chat
//
//  Created by Marius Ilie on 28/03/17.
//  Copyright © 2017 Marius Ilie. All rights reserved.
//

import UIKit
import RxSwift

extension UIView {
    func fadeIn(withDuration duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(withDuration duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func addContentDropShadow() {
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
}
