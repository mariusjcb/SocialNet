//
//  PFObject.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 13/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import Parse
import RxSwift
import RxCocoa

extension PFSubclassing where Self: PFObject {
    static func query(_ conditions: [PFKey<Self>: Conditions]) throws -> PFQuery<PFObject> {
        var queries = [PFQuery]()
        for dictionaryValue in conditions {
            let key = dictionaryValue.key.rawValue
            let condition = dictionaryValue.value.rawValue
            let object = dictionaryValue.value.target
            
            guard let query = Self.query()?.whereKey(key, condition: condition, object: object) else {
                continue
            }
            
            queries.append(query)
        }
        
        return PFQuery.orQuery(withSubqueries: queries)
    }
}
