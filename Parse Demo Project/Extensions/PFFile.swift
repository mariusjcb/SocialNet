//
//  PFFile.swift
//  Parse Demo Project
//
//  Created by Ilie Marius on 10/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit
import Parse
import RxSwift

extension Reactive where Base: PFFile {
    func requestData() -> Single<Data> {
        return Single.create { (observer) -> Disposable in
            (self.base as PFFile).getDataInBackground(block: { (data, error) in
                if error != nil {
                    observer(.error(error!))
                } else {
                    observer(.success(data!))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func requestImage() -> Single<UIImage> {
        return requestData().flatMap { data in
            guard let image = UIImage(data: data) else {
                return Observable.error(GenericError.typeError).asSingle()
            }
            
            return Observable.just(image).asSingle()
        }
    }
}
