//
//  PFObjectDemo.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 13/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import Parse

class PFObjectDemo: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "DEMO"
    }
}
