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
}
