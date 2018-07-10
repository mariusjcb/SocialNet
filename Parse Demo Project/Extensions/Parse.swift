//
//  Parse.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import Parse

extension Parse {
    class func setupWithConfiguration(fromPlist plistFile: String, key: String = "ParseServer") throws {
        let infoPlist = try PlistFile(named: plistFile)
        let configuration = ParseClientConfiguration.from(dictionary: infoPlist.contents[key] as! [String: String])
        
        Parse.initialize(with: configuration)
        
        print("---------------------------------------")
        print(Parse.getApplicationId())
        print(Parse.currentConfiguration()!.server)
        print("---------------------------------------")
    }
}
