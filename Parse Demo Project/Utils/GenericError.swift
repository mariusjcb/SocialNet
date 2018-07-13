//
//  GenericError.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

enum GenericError: Error {
    case invalidArgsNumber
    case typeError
    case fileNotFound
}
