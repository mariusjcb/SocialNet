//
//  NibInstantiable.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 13/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit

protocol NibInstantiable: RawRepresentable {
    static func instantiate(_ nib: Self) -> UINib
}

extension NibInstantiable where RawValue == String {
    static func instantiate(_ nib: Self) -> UINib {
        return UINib(nibName: nib.rawValue, bundle: nil)
    }
}

