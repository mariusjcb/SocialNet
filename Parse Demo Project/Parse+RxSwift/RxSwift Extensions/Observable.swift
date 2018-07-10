//
//  Observable.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 10/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    class func create(_ callback: @escaping (AnyObserver<E>) -> Void) -> Observable<E> {
        return Observable.create({ observer -> Disposable in
            callback(observer)
            return Disposables.create()
        })
    }
}
