//
//  PFObject.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 13/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import Parse

struct PFKey<T>: RawRepresentable, Hashable {
    typealias RawValue = String
    var rawValue: String
    
    init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static func value(_ rawValue: String) -> PFKey<T> {
        return PFKey<T>(rawValue: rawValue)!
    }
}

extension PFObject {
    enum Option {
        case optionKeyMaxDistance(Any)
        case optionKeyBox(Any)
        case optionKeyPolygon(Any)
        case optionKeyPoint(Any)
        case optionKeySearch(Any)
        case optionKeyTerm(Any)
        case optionKeyRegexOptions(Any)
        
        var rawValue: String {
            switch self {
            case .optionKeyMaxDistance: return PFQueryOptionKeyMaxDistance
            case .optionKeyBox: return PFQueryOptionKeyBox
            case .optionKeyPolygon: return PFQueryOptionKeyPolygon
            case .optionKeyPoint: return PFQueryOptionKeyPoint
            case .optionKeySearch: return PFQueryOptionKeySearch
            case .optionKeyTerm: return PFQueryOptionKeyTerm
            case .optionKeyRegexOptions: return PFQueryOptionKeyRegexOptions
            }
        }
        
        var target: Any {
            switch self {
            case .optionKeyMaxDistance(let obj): return obj
            case .optionKeyBox(let obj): return obj
            case .optionKeyPolygon(let obj): return obj
            case .optionKeyPoint(let obj): return obj
            case .optionKeySearch(let obj): return obj
            case .optionKeyTerm(let obj): return obj
            case .optionKeyRegexOptions(let obj): return obj
            }
        }
    }
    
    enum Conditions {
        case contains(String)
        case notEqualTo(Any)
        case lessThan(Any)
        case lessThanEqualTo(Any)
        case greaterThan(Any)
        case greaterThanOrEqualTo(Any)
        case containedIn(Any)
        case notContainedIn(Any)
        case containsAll(Any)
        case nearSphere(Any)
        case within(Any)
        case geoWithin(Any)
        case geoIntersects(Any)
        case regex(String)
        case text(Any)
        case exists(Any)
        case inQuery(Any)
        case notInQuery(Any)
        case select(Any)
        case dontSelect(Any)
        case relatedTo(Any)
        case or(Any)
        case query(Any)
        case key(Any)
        case object(Any)
        
        var rawValue: String {
            switch self {
            case .contains: return PFQueryKeyRegex
            case .notEqualTo: return PFQueryKeyNotEqualTo
            case .lessThan: return PFQueryKeyLessThan
            case .lessThanEqualTo: return PFQueryKeyLessThanEqualTo
            case .greaterThan: return PFQueryKeyGreaterThan
            case .greaterThanOrEqualTo: return PFQueryKeyGreaterThanOrEqualTo
            case .containedIn: return PFQueryKeyContainedIn
            case .notContainedIn: return PFQueryKeyNotContainedIn
            case .containsAll: return PFQueryKeyContainsAll
            case .nearSphere: return PFQueryKeyNearSphere
            case .within: return PFQueryKeyWithin
            case .geoWithin: return PFQueryKeyGeoWithin
            case .geoIntersects: return PFQueryKeyGeoIntersects
            case .regex: return PFQueryKeyRegex
            case .text: return PFQueryKeyText
            case .exists: return PFQueryKeyExists
            case .inQuery: return PFQueryKeyInQuery
            case .notInQuery: return PFQueryKeyNotInQuery
            case .select: return PFQueryKeySelect
            case .dontSelect: return PFQueryKeyDontSelect
            case .relatedTo: return PFQueryKeyRelatedTo
            case .or: return PFQueryKeyOr
            case .query: return PFQueryKeyQuery
            case .key: return PFQueryKeyKey
            case .object: return PFQueryKeyObject
            }
        }
        
        var target: Any {
            switch self {
            case .contains(let obj): return PFQueryUtilities.regexString(for: obj)
            case .notEqualTo(let obj): return obj
            case .lessThan(let obj): return obj
            case .lessThanEqualTo(let obj): return obj
            case .greaterThan(let obj): return obj
            case .greaterThanOrEqualTo(let obj): return obj
            case .containedIn(let obj): return obj
            case .notContainedIn(let obj): return obj
            case .containsAll(let obj): return obj
            case .nearSphere(let obj): return obj
            case .within(let obj): return obj
            case .geoWithin(let obj): return obj
            case .geoIntersects(let obj): return obj
            case .regex(let obj): return PFQueryUtilities.regexString(for: obj)
            case .text(let obj): return obj
            case .exists(let obj): return obj
            case .inQuery(let obj): return obj
            case .notInQuery(let obj): return obj
            case .select(let obj): return obj
            case .dontSelect(let obj): return obj
            case .relatedTo(let obj): return obj
            case .or(let obj): return obj
            case .query(let obj): return obj
            case .key(let obj): return obj
            case .object(let obj): return obj
            }
        }
    }
}
