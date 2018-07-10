//
//  UILoadButton.swift
//  SUB Chat
//
//  Created by Marius Ilie on 28/03/17.
//  Copyright © 2017 Marius Ilie. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class UILoadButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 3.0
    var spinnerView: UIActivityIndicatorView?
    var buttonTitleLabel: UILabel?
    
    private enum SpinnerStatusCases {
        case inactive
        case active
    }
    private var spinnerStatus: SpinnerStatusCases = .inactive
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        
        self.titleLabel?.frame.size.width = self.frame.size.width
        self.titleLabel?.frame.size.height = self.frame.size.height
        
        self.buttonTitleLabel = UILabel()
        
        self.buttonTitleLabel?.textAlignment = .center
        self.buttonTitleLabel?.baselineAdjustment = .alignCenters
        self.buttonTitleLabel?.font = self.titleLabel?.font
        self.buttonTitleLabel?.textColor = self.titleLabel?.textColor
        self.buttonTitleLabel?.text = self.titleLabel?.text
        
        self.addSubview(self.buttonTitleLabel!)
        
        self.buttonTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.buttonTitleLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.buttonTitleLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.titleLabel?.removeFromSuperview()
        
        self.spinnerView = UIActivityIndicatorView()
        self.spinnerView?.activityIndicatorViewStyle = .white
        self.spinnerView?.alpha = 0
        
        self.addSubview(self.spinnerView!)
        
        self.spinnerView?.translatesAutoresizingMaskIntoConstraints = false
        self.spinnerView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.spinnerView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
    
    @objc private func touchUpInside() {
        if spinnerStatus == .inactive {
            animateIn()
        } else {
            animateOut()
        }
    }
    
    func animateIn() {
        spinnerStatus = .active
        
        self.spinnerView?.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        self.spinnerView?.startAnimating()
        
        UIView.animate(withDuration: 0.1) {
            self.buttonTitleLabel?.alpha = 0
            self.spinnerView?.alpha = 1
            self.spinnerView?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }
    }
    
    func animateOut() {
        spinnerStatus = .inactive
        
        self.buttonTitleLabel?.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.buttonTitleLabel?.transform = CGAffineTransform.identity
            self.buttonTitleLabel?.alpha = 1
            self.spinnerView?.alpha = 0
            self.spinnerView?.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        }) { _ in
            self.spinnerView?.stopAnimating()
        }
    }
}
