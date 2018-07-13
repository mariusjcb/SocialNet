//
//  User+Rx.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 12/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import RxSwift
import Parse

extension User {
    fileprivate static let currentUserSubject = BehaviorSubject<User?>(value: nil)
    
    fileprivate func pushCurrentSubjectIfNeeded() {
        if self == User.current() {
            User.currentUserSubject.onNext(self)
        }
    }
    
    override func save() throws {
        try super.save()
        pushCurrentSubjectIfNeeded()
    }
    
    override func saveEventually(_ callback: PFBooleanResultBlock? = nil) {
        super.saveEventually { (success, error) in
            self.pushCurrentSubjectIfNeeded()
            callback?(success, error)
        }
    }
    
    override func saveInBackground(block: PFBooleanResultBlock? = nil) {
        super.saveInBackground { (success, error) in
            self.pushCurrentSubjectIfNeeded()
            block?(success, error)
        }
    }
    
    override func fetch() throws -> User {
        let user = try super.fetch() as! User
        pushCurrentSubjectIfNeeded()
        
        return user
    }
    
    override func fetchInBackground(block: PFObjectResultBlock? = nil) {
        super.fetchInBackground { (success, error) in
            self.pushCurrentSubjectIfNeeded()
            block?(success, error)
        }
    }
    
    override func signUpInBackground(block: PFBooleanResultBlock? = nil) {
        super.signUpInBackground { (success, error) in
            self.pushCurrentSubjectIfNeeded()
            block?(success, error)
        }
    }
    
    override func signUp() throws {
        try super.signUp()
        pushCurrentSubjectIfNeeded()
    }
    
    override class func logOut() -> Void {
        super.logOut()
        User.currentUserSubject.onNext(nil)
    }
    
    override class func logOutInBackground(block: PFUserLogoutResultBlock?) -> Void {
        super.logOutInBackground { (error) in
            User.currentUserSubject.onNext(nil)
            block?(error)
        }
    }
    
    override class func logInWithUsername(inBackground username: String, password: String, block: PFUserResultBlock?) {
        super.logInWithUsername(inBackground: username, password: password) { (success, error) in
            User.current()?.pushCurrentSubjectIfNeeded()
            block?(success, error)
        }
    }
}

extension Reactive where Base: User {
    static var currentUser: BehaviorSubject<User?> {
        return User.currentUserSubject
    }
}
