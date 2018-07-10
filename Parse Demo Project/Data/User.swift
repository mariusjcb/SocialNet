//
//  User.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Parse

class User: PFUser {
    fileprivate(set) var firstName: String?
    fileprivate(set) var lastName: String?
    fileprivate(set) var phone: String?
    fileprivate(set) var profilePicture: PFFile?
    
    fileprivate(set) var isFirstLogin: Bool = true
}

extension User {
    func save(firstName: String, lastName: String, profilePicture: UIImage, block: @escaping PFBooleanResultBlock) throws {
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = PFFile(data: UIImagePNGRepresentation(profilePicture)!)
        
        self.saveInBackground(block: block)
    }
    
    func save(phoneNumber: String, block: @escaping PFBooleanResultBlock) throws {
        self.phone = phoneNumber
        self.saveInBackground(block: block)
    }
}
