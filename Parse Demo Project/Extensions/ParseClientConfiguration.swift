//
//  ParseConfiguration.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import Parse

extension ParseClientConfiguration {
    class func from(dictionary: [String: String]) -> ParseClientConfiguration {
        let applicationId = dictionary[Keys.applicationId.rawValue]!
        let serverUrl = dictionary[Keys.serverUrl.rawValue]!

        return ParseClientConfiguration {
            $0.applicationId = applicationId
            $0.server = serverUrl
        }
    }
}

extension ParseClientConfiguration {
    enum Keys: String {
        case applicationId = "ApplicationID"
        case serverUrl = "ServerUrl"
    }
}
