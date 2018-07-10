//
//  StoryboardReferenceRepresentable.swift
//  SEOmonitor
//
//  Created by Marius Ilie on 23/03/2018.
//  Copyright © 2018 mReady. All rights reserved.
//

import UIKit

protocol StoryboardReferenceRepresentable: RawRepresentable {
    static var storyboardName: String { get }
    static var initialViewController: UIViewController? { get }
    static func instantiateStoryboard() -> UIStoryboard
    static func instantiate(viewController: Self) -> UIViewController
}

extension StoryboardReferenceRepresentable where RawValue == String {
    static var initialViewController: UIViewController? {
        return instantiateStoryboard().instantiateInitialViewController()
    }
    
    static func instantiateStoryboard() -> UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    static func instantiate(viewController: Self) -> UIViewController {
        return instantiateStoryboard().instantiateViewController(withIdentifier: viewController.rawValue)
    }
}
