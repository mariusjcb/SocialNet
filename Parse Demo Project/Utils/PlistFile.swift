//
//  PlistReader.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

class PlistFile {
    fileprivate(set) var contents: [String: Any]
    
    init(named: String) throws {
        if let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let url = URL(fileURLWithPath: filePath)
            contents = NSDictionary(contentsOf: url) as! [String: Any]
        } else {
            throw GenericError.fileNotFound
        }
    }
}
