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
    @NSManaged fileprivate(set) var firstName: String?
    @NSManaged fileprivate(set) var lastName: String?
    @NSManaged fileprivate(set) var phone: String?
    @NSManaged fileprivate(set) var profilePicture: PFFile?
    
    @NSManaged var hasDoneFirstSteps: Bool
}

extension User {
    override var parseClassName: String {
        return super.parseClassName
    }
    
    func save(firstName: String, lastName: String, profilePicture: UIImage, block: @escaping PFBooleanResultBlock) {
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = PFFile(data: UIImagePNGRepresentation(profilePicture)!)
        
        self.profilePicture?.saveInBackground(block: { [weak self] success, error in
            guard success else {
                block(false, error)
                return
            }
            
            self?.saveEventually(block)
        })
    }
    
    func save(phoneNumber: String, block: @escaping PFBooleanResultBlock) {
        self.phone = phoneNumber
        self.saveEventually(block)
    }
}
