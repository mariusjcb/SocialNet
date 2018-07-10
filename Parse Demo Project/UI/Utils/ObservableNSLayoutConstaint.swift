//
//  ObservableNSLayoutConstaint.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 10/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit

class ObservableNSLayoutConstaint: NSLayoutConstraint {
    override var constant: CGFloat {
        willSet {
            print(newValue)
        }
    }
}
